require 'open-uri'
require 'nokogiri'

class DairyController < ApplicationController
  def index
    @blog_posts = fetch_blog_posts
  end

  private

  def fetch_blog_posts
    url = 'https://world.hey.com/rushi.patel/feed.atom'
    document = Nokogiri::XML(URI.open(url))
    document.remove_namespaces!

    document.xpath('//entry').map do |entry|
      {
        title: entry.xpath('title').text,
        category: 'Dairy',
        url: entry.at_xpath('link[@rel="alternate"]')['href'],
        published_at: entry.xpath('published').text
      }
    end
  end
end