require 'nokogiri'
require 'open-uri'
class TechController < ApplicationController
    include FeedFetcher

    def index
        @tech_posts = fetch_posts('tech')
        @open_post_id = params[:post]
    end
end