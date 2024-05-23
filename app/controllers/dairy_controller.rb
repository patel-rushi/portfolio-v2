require 'open-uri'
require 'nokogiri'

class DairyController < ApplicationController
  include FeedFetcher
  
  def index
    @blog_posts = fetch_dairy_posts
  end

  private

  def fetch_dairy_posts
    fetch_feed_entries('https://world.hey.com/rushi.patel/feed.atom').map do |entry|
      next if entry.xpath('title').text.include?('[Tech]')
      parse_entry(entry).merge(category: 'Diary')
    end.compact
  end
end