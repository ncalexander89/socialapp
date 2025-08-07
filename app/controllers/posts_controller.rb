class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Include current_user + all followed users
    followed_user_ids = current_user.following.pluck(:id)
    visible_user_ids = followed_user_ids << current_user.id
  
    @posts = Post.includes(:user, :likes, comments: :user)
                 .where(user_id: visible_user_ids)
                 .order(created_at: :desc)
  end
  

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post created successfully!"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
