class CommentsController < ApplicationController
  def create
    @link = Link.find(params[:link_id])
    @comment = current_user.comments.new(comment_params)
    @comment.link_id = @link.id

    if @comment.save
      redirect_to link_url(@comment.link_id)
    else
      render 'links/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_comment_id)
  end
end