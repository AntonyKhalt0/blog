class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post, only: [:show, :new, :edit, :update, :destroy]

  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 5)
  end

  def show
    @post = Post(params[:id])
  end

  def new; end

  def create
    @post = current_user.posts.build(post_params)

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
    params.require(:posts).permit(:title, :description)
  end

  def get_post
    @post = params[:id] ? Post(params[:id]) : Post.new
  end
end
