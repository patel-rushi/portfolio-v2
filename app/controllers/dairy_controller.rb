require 'open-uri'
require 'nokogiri'

class DairyController < ApplicationController
  include FeedFetcher
  
  def index
    @blog_posts = fetch_dairy_posts
    @open_post_id = params[:post]
  end

  private

  def fetch_dairy_posts
    all_entries = []
    PAGE_PARAMS.each do |page_param|
        page_url = "#{BASE_URL}#{page_param}"
        entries = fetch_feed_entries(page_url).map do |entry|
          next if entry.xpath('title').text.include?('[Tech]')
          parse_entry(entry).merge(category: 'Diary')
        end.compact
        all_entries.concat(entries)
    end
    all_entries
  end
end