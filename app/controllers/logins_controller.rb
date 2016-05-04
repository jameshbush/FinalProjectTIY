class LoginsController < ApplicationController

  before_action :disallow_user, only: [:new, :create]
  before_action :require_user,  only: [:distroy]

  def new
  end

  def create
    @user = User.find_by(email: params[:login][:email])
    if @user && @user.authenticate(params[:login][:password])
      session[:current_user_id] = @user.id
      redirect_to user_show_path
    else
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_url
  end
end
