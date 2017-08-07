class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.find_by(:user_id => current_user.id, :post_id => @post.id)
    if !@like
      @post.likes.create(:user_id => current_user.id)
    else
      @like.destroy
    end

    render json: {new_like_count: @post.likes.count}
  end
end
