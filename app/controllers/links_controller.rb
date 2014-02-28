class LinksController < ApplicationController
  before_action :load_subs, only: [:new, :create]

  def show
    @link = Link.find(params[:id])
    @comments = @link.comments_by_parent_id
    @comment = Comment.new
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to @link
    else
      render :new
    end
  end

  private
  def link_params
    params.require(:link).permit(:title, :url, :description, { sub_ids: [] })
  end

  def load_subs
    @subs = Sub.all
  end
end
