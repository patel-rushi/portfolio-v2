module FeedFetcher
    extend ActiveSupport::Concern
    
    private
    
    def fetch_feed_entries(url)
        document = Nokogiri::XML(URI.open(url))
        document.remove_namespaces!
        document.xpath('//entry')
    end

    def parse_entry(entry)
        {
          id: entry.xpath('id').text.split('/').last,
          title: entry.xpath('title').text,
          url: entry.at_xpath('link[@rel="alternate"]')['href'],
          published_at: entry.xpath('published').text,
          content: entry.xpath('content').text,
        }
    end
end