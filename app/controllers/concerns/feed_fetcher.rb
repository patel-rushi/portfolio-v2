module FeedFetcher
    extend ActiveSupport::Concern
    
    private
    included do
        BASE_URL = 'https://world.hey.com/rushi.patel/feed.atom'.freeze
        PAGE_PARAMS = [
            '', # First page doesn't have a page parameter
            '?page=eyJwYWdlX251bWJlciI6MiwidmFsdWVzIjp7ImNyZWF0ZWRfYXQiOiIyMDI0LTAxLTIyVDAyOjE0OjU0LjE2MTQzMloiLCJpZCI6MzQ1OTN9fQ%3D%3D',
            '?page=eyJwYWdlX251bWJlciI6MywidmFsdWVzIjp7ImNyZWF0ZWRfYXQiOiIyMDIzLTExLTI4VDIyOjAxOjE2LjQwODU1OVoiLCJpZCI6MzMwMzF9fQ%3D%3D'
            # Add more pages as needed
        ].freeze
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
end