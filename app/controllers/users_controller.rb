class UsersController < ApplicationController
  before_action :find_user, only:[:edit, :update, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      flash[:success] = "User created"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Account Updated"
      redirect_to root_url
    else
      render :edit
    end
  end


  def show
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end