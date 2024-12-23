require 'open-uri'
require 'nokogiri'

class DairyController < ApplicationController
  include FeedFetcher
  include FeedFilters
  
  def index
    @page = params[:page].presence_in(FeedFilters::NAMES.keys.map(&:to_s)) || FeedFilters::NAMES.keys.first.to_s
    @blog_posts = fetch_posts(@page) || []
    @open_post_id = params[:post]
  end
end