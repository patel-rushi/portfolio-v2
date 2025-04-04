# lib/tasks/post_fetcher.rake
require 'nokogiri'
require 'open-uri'

namespace :posts do
  desc "Fetch and store posts from the feed"
  task fetch_and_store: :environment do
    # Multiple tag example: 
    # tags: ['[Script]', '[Monologue]']
    BASE_URL = Rails.application.credentials.dig(:feed, :base_url).freeze
    PAGE_PARAMS = Rails.application.credentials.dig(:feed, :page_params).freeze
    IMAGE_DIR = Rails.root.join('public', 'images', 'posts')

    CATEGORIES = {
      notes: { tags: [], name: FeedFilters::NAMES[:notes] },
      scripts: { tags: ['[Script]'], name: FeedFilters::NAMES[:scripts] },
      reels: { tags: ['[Reel]'], name: FeedFilters::NAMES[:reels] },
      tech: { tags: ['[Tech]'], name: FeedFilters::NAMES[:tech] }
    }.freeze

    def fetch_and_store_posts
      blog_posts = []
      FeedFilters::NAMES.keys.each do |key|
        blog_posts << fetch_posts(key.to_s)
      end
      blog_posts.flatten.each do |post_data|
        post = Post.find_by(remote_id: post_data[:remote_id])
      
        if post
          # Update the existing post
          post.update!(
            title: post_data[:title],
            published_at: post_data[:published_at],
            content: post_data[:content],
            category: post_data[:category],
            embed: post_data[:embed],
            url: post_data[:url],
            image_path: post_data[:image_path]
          )
        else
          # Create a new post
          Post.create!(
            remote_id: post_data[:remote_id],
            title: post_data[:title],
            published_at: post_data[:published_at],
            content: post_data[:content],
            category: post_data[:category],
            embed: post_data[:embed],
            url: post_data[:url],
            image_path: post_data[:image_path]
          )
        end
      end
    end

    def fetch_posts(page)
      category_tags = page.present? ? CATEGORIES.dig(page.to_sym, :tags) : []

      all_entries = []
      PAGE_PARAMS.each do |page_param|
        page_url = "#{BASE_URL}#{page_param}"
        entries = fetch_feed_entries(page_url).map do |entry|
          title = entry.xpath('title').text
          if category_tags.any?
            next unless category_tags.any? { |tag| title.include?(tag) }
          else
            next if CATEGORIES.values.any? { |cat| cat[:tags].any? { |tag| title.include?(tag) } }
          end
          extract_content_from_xml(entry, page)
        end.compact
        all_entries.concat(entries)
      end
      all_entries
    end

    def fetch_feed_entries(url)
      document = Nokogiri::XML(URI.open(url))
      document.remove_namespaces!
      document.xpath('//entry')
    end

    def extract_content_from_xml(entry, page)
      embed_iframe, post_url = extract_iframe_url(entry)
      category = if page == 'tech'
                  embed_iframe.present? ? 'tech' : CATEGORIES.dig(page.to_sym, :name)
                else
                  page.present? ? CATEGORIES.dig(page.to_sym, :name) : CATEGORIES.values.first[:name]
                end
      parse_entry(entry).merge(
        category: category,
        title: entry.xpath('title').text.gsub(/\[.*?\]/, '').strip,
        embed: embed_iframe,
        content: embed_iframe.present? ? 'Press to checkout post' : save_images_and_edit_content(entry.xpath('content').text, true),
        url: entry.xpath('link[@rel="alternate"]').first['href'],
        image_path: save_images_and_edit_content(entry.xpath('content').text, false)
      )
    end

    def parse_entry(entry)
      {
        remote_id: entry.xpath('id').text.split('/').last,
        title: entry.xpath('title').text,
        published_at: entry.xpath('published').text,
        content: entry.xpath('content').text,
      }
    end

    def extract_iframe_url(entry)
      content_encoded = entry.xpath('content').text
      content_decoded_once = CGI.unescapeHTML(content_encoded)
      content_fully_decoded = CGI.unescapeHTML(content_decoded_once)

      # Extract the URL for the iframe
      url_regex = /<iframe[^>]+src="\s*<a href="([^"]+)"/
      url_match = url_regex.match(content_fully_decoded)
      return [nil, nil] unless url_match
      iframe_url = url_match[1]

      # Extract the height for the iframe
      height_regex = /height="(\d+)"/
      height_match = height_regex.match(content_fully_decoded)
      iframe_height = height_match[1] if height_match

      # Extract the LinkedIn post URL
      additional_url_regex = /url="[^"]+href="([^"]+)"/
      additional_url_match = additional_url_regex.match(content_fully_decoded)
      post_url = additional_url_match[1] if additional_url_match

      # Construct the iframe tag with the extracted URL
      iframe_html = if iframe_url
                      "<iframe src=\"#{iframe_url}\" height=\"#{iframe_height || '1000'}\" width=\"96%\" frameborder=\"0\" allowfullscreen title=\"Embedded post\" class=\"custom-height\"></iframe>"  
                    end

      [iframe_html, post_url]
    end

    def save_images_and_edit_content(content, return_edited_content = false)
      FileUtils.mkdir_p(IMAGE_DIR) unless Dir.exist?(IMAGE_DIR)
      image_urls = content.scan(/<img[^>]+src="([^"]+)"/).flatten

      image_paths = image_urls.map do |url|
        filename = URI.decode_www_form_component(File.basename(URI.parse(url).path))
        
        filepath = IMAGE_DIR.join(filename)

        # Download the image
        unless File.exist?(filepath)
          # Download the image
          File.open(filepath, 'wb') do |file|
            file.write(URI.open(url).read)
          end
        end

        local_path = filepath.to_s.sub(Rails.root.join('public').to_s, '')
        content.gsub!(url, local_path)
      end

      if image_urls.present?
        # Update href attributes in <a> tags
        content.gsub!(/<a[^>]+href="([^"]+)"/) do |match|
          url = $1
          if url.include?('world.hey.com')
            filename = File.basename(URI.parse(url).path)
            local_path = IMAGE_DIR.join(filename).to_s.sub(Rails.root.join('public').to_s, '')
            match.gsub(url, local_path)
          else
            match
          end
        end

        # Update srcset attributes in <img> tags
        content.gsub!(/<img[^>]+srcset="([^"]+)"/) do |match|
          srcset = $1
          updated_srcset = srcset.split(',').map do |src|
            url, descriptor = src.strip.split(' ')
            if url.include?('world.hey.com')
              filename = File.basename(URI.parse(url).path)
              local_path = IMAGE_DIR.join(filename).to_s.sub(Rails.root.join('public').to_s, '')
              "#{local_path} #{descriptor}"
            else
              src
            end
          end.join(', ')
          match.gsub(srcset, updated_srcset)
        end
      end

      if return_edited_content
        content
      else
        image_paths.present? ? image_paths.join(', ') : nil
      end
    end

    fetch_and_store_posts
  end
end