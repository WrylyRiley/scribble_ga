class CommentsController < ApplicationController
  def new
    if current_user
      @post = Post.find(params[:post_id])
      @comment = Comment.new
    else
      flash[:alert] = "Must be signed in to leave a comment"
    end
  end

  def create
    if current_user
      @post = Post.find(params[:post_id])
      @comment = current_user.comments.create(comment_params)
    else
      flash[:alert] = "Must be signed in to leave a comment"
    end
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if current_user != @comment.user
      flash[:alert] = "Must be signed in to leave a comment"
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.update(comment_params)
    else
      flash[:alert] = "Must be signed in to update a comment"
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
