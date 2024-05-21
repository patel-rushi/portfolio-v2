require 'nokogiri'
require 'open-uri'
class TechController < ApplicationController
    include FeedFetcher

    def index
        @tech_posts = fetch_tech_posts
    end

    private

    def fetch_tech_posts
        fetch_feed_entries('https://world.hey.com/rushi.patel/feed.atom').map do |entry|
          next unless entry.xpath('title').text.include?('[Tech]')
          embed_iframe, post_url = extract_iframe_url(entry)
          parse_entry(entry).merge(
            category: embed_iframe.present? ? 'Linkedin Post' : 'Tech', 
            title: entry.xpath('title').text.gsub('[Tech]', '').strip, 
            embed: embed_iframe,
            content: embed_iframe.present? ? 'Press to checkout post' :  entry.xpath('content').text,
            url: embed_iframe.present? ? post_url : ''
          )
        end.compact
    end

    def extract_iframe_url(entry)
        content_encoded = entry.xpath('content').text
        content_decoded_once = CGI.unescapeHTML(content_encoded)
        content_fully_decoded = CGI.unescapeHTML(content_decoded_once)
        
        # Extract the URL for the iframe
        url_regex = /href="([^"]+)"/
        url_match = url_regex.match(content_fully_decoded)
        iframe_url = url_match[1] if url_match

        # Extract the height for the iframe
        height_regex = /height="(\d+)"/
        height_match = height_regex.match(content_fully_decoded)
        iframe_height = height_match[1] if height_match

        # Extract the linkedIn post url:
        additional_url_regex = /url="[^"]+href="([^"]+)"/
        additional_url_match = additional_url_regex.match(content_fully_decoded)
        post_url = additional_url_match[1] if additional_url_match

        # Construct the iframe tag with the extracted URL
        iframe_html = if iframe_url
                        "<iframe src=\"#{iframe_url}\" height=\"#{iframe_height || '1000'}\" width=\"96%\" frameborder=\"0\" allowfullscreen title=\"Embedded post\"></iframe>"  
                    end

        [iframe_html, post_url]
    end
end