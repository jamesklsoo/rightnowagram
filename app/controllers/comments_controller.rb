class CommentsController < ApplicationController
  def create
    comment = current_user.comments.new(comment_params)
    comment.post_id = params[:post][:id]
    if comment.save
      flash[:success] = "Comment created!"
    else
      flash[:error] = "There was an error creating your comment!"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
