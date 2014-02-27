class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:session][:username],
      params[:session][:password]
    )
    if @user
      login!(@user)
      flash[:success] = "Aww yeah! It's time :)"
      redirect_to root_url
    else
      flash.now[:danger] = "Wrong credentials"
      render :new
    end
  end

  def destroy
    log_out!
    flash[:success] = "Goodbye :P"
    redirect_to root_url
  end
end