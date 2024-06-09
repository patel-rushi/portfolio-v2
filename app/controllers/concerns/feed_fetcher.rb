module FeedFetcher
    extend ActiveSupport::Concern
    
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
end