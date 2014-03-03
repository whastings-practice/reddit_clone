class SubsController < ApplicationController
  before_action :find_sub, only: [:show, :edit, :update]
  before_action :require_signed_in, only: [:new, :create, :edit, :update]

  def show
    @links = @sub.links.by_popularity
  end

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
    5.times { @sub.links.build }
  end

  def create
    @sub = current_user.moderated_subs.new(sub_params)
    @sub.links.each{ |link| link.user_id = current_user.id }
    if @sub.save
      redirect_to @sub
    else
      (5 - @sub.links.length).times { @sub.links.build }
      render :new
    end
  end

  def edit
  end

  def update
    if @sub.update_attributes(sub_params)
      redirect_to @sub
    else
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(
      :name, links_attributes: [:title, :url, :description ]
    )
  end

  def find_sub
    @sub = Sub.find(params[:id])
  end
end
