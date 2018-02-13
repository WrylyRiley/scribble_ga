class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
      flash[:alert] = "Only the author of the post can edit!"
      redirect_to post_path(@post)
    end
  end

  def new
    isAuthenticated
    @post = Post.new
  end

  def create
    isAuthenticated
    @post = current_user.posts.create!(post_params)
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.update(post_params)
    else
      flash[:alert] = "Only the author of a post can edit"
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
    else
      flash[:alert] = "Only the author of the post can delete"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def isAuthenticated
    if !current_user
      flash[:alert] = "Only a user can modify/create posts"
      redirect_to user_session_path
    end
  end
end
