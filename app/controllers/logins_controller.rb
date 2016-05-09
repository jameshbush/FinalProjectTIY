class LoginsController < ApplicationController

  before_action :disallow_user, only: [:new, :create]
  before_action :require_user,  only: [:distroy]

  def new
  end

  def create
    @user = User.find_by(email: params[:login][:email])
    if @user && @user.authenticate(params[:login][:password])
      session[:current_user_id] = @user.id
      if @user.has_current_journey?
        redirect_to user_path(current_user)
      else
        redirect_to journey_create_path
      end
    else
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_url
  end
end
