class PostsController < ApplicationController
    before_action :authenticate
    before_action :set_post, only: [:edit, :update, :destroy]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
          redirect_to dairy_index_path, notice: 'Post was successfully created.'
        else
          render :new
        end
    end

    def edit
    end
    
    def update
      if @post.update(post_params)
        redirect_to dairy_index_path, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      redirect_to dairy_index_path, notice: 'Post was successfully deleted.'
    end
    
    private
    
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:category, :title, :content, :embed)
    end
end