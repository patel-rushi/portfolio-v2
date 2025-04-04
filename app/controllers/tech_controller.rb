require 'nokogiri'
require 'open-uri'
class TechController < ApplicationController
    include FeedFilters
    
    def index
        @tech_posts = Post.where(category: FeedFilters::NAMES[:tech]).order('published_at DESC, created_at DESC')
        @open_post_id = params[:post]
    end
end