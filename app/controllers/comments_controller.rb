class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :post, only: :create

  def create
    @comment = post.comments.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to @comment.post
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def post
    @post = Post.find(params[:post_id])
  end
end
