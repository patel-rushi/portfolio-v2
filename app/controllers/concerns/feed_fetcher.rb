module FeedFetcher
    extend ActiveSupport::Concern
    include FeedFilters

    # Multiple tag example: 
    # tags: ['[Script]', '[Monologue]']
    CATEGORIES = {
      notes: { tags: [], name: FeedFilters::NAMES[:notes] },
      scripts: { tags: ['[Script]'], name: FeedFilters::NAMES[:scripts] },
      reels: { tags: ['[Reel]'], name: FeedFilters::NAMES[:reels] },
      tech: { tags: ['[Tech]'], name: FeedFilters::NAMES[:tech] }
    }.freeze

    private
    included do
        # Update both development and produdction credentials
        BASE_URL = Rails.application.credentials.dig(:feed, :base_url).freeze
        PAGE_PARAMS = Rails.application.credentials.dig(:feed, :page_params).freeze
    end

    def fetch_feed_entries(url)
        document = Nokogiri::XML(URI.open(url))
        document.remove_namespaces!
        document.xpath('//entry')
    end

    def parse_entry(entry)
        {
          id: entry.xpath('id').text.split('/').last,
          title: entry.xpath('title').text,
          published_at: entry.xpath('published').text,
          content: entry.xpath('content').text,
        }
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
    
      def extract_content_from_xml(entry, page)
        embed_iframe, post_url = extract_iframe_url(entry)
        category = if page == 'tech'
               embed_iframe.present? ? 'Linkedin Post' : CATEGORIES.dig(page.to_sym, :name)
             else
              page.present? ? CATEGORIES.dig(page.to_sym, :name) : 'Thought'
             end
        parse_entry(entry).merge(
          category: category,
          title: entry.xpath('title').text.gsub(/\[.*?\]/, '').strip,
          embed: embed_iframe,
          content: embed_iframe.present? ? 'Press to checkout post' : entry.xpath('content').text,
          url: embed_iframe.present? ? post_url : ''
        )
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
end