class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    current_user.likes.create(post: post)
    redirect_to posts_path
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: post)
    like&.destroy
    redirect_to posts_path
  end
end
