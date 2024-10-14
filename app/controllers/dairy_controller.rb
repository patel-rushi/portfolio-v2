require 'open-uri'
require 'nokogiri'

class DairyController < ApplicationController
  include FeedFetcher
  
  def index
    @blog_posts = fetch_posts(params[:page])
    @open_post_id = params[:post]
  end
end