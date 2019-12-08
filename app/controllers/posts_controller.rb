class PostsController < ApplicationController
  before_action :check_logged_in, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: params[:post][:title], content: params[:post][:content], user_id: session[:user_id])
    if @post.save
      # flash[:success] = "Post created successfully."
      redirect_to posts_path
    else
      render "new"
    end
  end

  def index
    @posts = Post.all
  end
end
