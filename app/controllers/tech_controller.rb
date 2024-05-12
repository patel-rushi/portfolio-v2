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
          parse_entry(entry).merge(
            category: 'Tech', 
            title: entry.xpath('title').text.gsub('[Tech]', '').strip, 
            embed: extract_iframe(entry)
          )
        end.compact
    end

    def extract_iframe(entry)
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

        # Construct the iframe tag with the extracted URL
        iframe_html = if iframe_url
                        "<iframe src=\"#{iframe_url}\" height=\"#{iframe_height || '1000'}\" width=\"100%\" frameborder=\"0\" allowfullscreen title=\"Embedded post\"></iframe>"  
                    end
    end
end