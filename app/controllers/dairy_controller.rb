require 'open-uri'
require 'nokogiri'

class DairyController < ApplicationController
  include FeedFilters
  include Paginatable

  CATEGORIES = FeedFilters::NAMES.except(:tech, :reels).freeze
  
  def index
    @page = params[:page].presence_in(CATEGORIES.keys.map(&:to_s)) || CATEGORIES.keys.first.to_s
    @blog_posts = paginate(Post.where(category: @page).search(params[:q]).order(published_at: :desc, id: :desc))
    @open_post_id = params[:post]
  end
end