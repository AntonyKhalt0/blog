# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post, only: %i[show new edit update destroy]

  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 6)
  end

  def show
    @images = @post.images.paginate(page: params[:page], per_page: 1)
  end

  def new; end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, images: [])
  end

  def get_post
    @post = params[:id] ? Post.find(params[:id]) : Post.new
  end
end
