require 'nokogiri'
require 'open-uri'
class TechController < ApplicationController
    include FeedFilters
    include Paginatable
    
    def index
        @tech_posts = paginate(Post.where(category: FeedFilters::NAMES[:tech]).search(params[:q]).order(published_at: :desc, id: :desc))
        @open_post_id = params[:post]
    end
end