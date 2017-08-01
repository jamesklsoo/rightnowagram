class LikesController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    # @post.user_id = current_user.id
    @post.likes.create
    render json: {new_like_count: @post.likes.count}

  end
end
