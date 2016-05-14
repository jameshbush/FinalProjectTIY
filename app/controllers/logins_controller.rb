class LoginsController < ApplicationController

  before_action :disallow_user, only: [:new, :create]
  before_action :require_user,  only: [:distroy]
  skip_before_action :require_email_confirmation, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: params[:login][:email])
    if @user && @user.authenticate(params[:login][:password])
      if user.email_confirmed
        session[:current_user_id] = @user.id
        flash[:success] = "You logged in!"
        render :root
      else
        flash[:error] = "Please activate your account."
        render :new
      end
    else
      flash[:error] = "Email or password wrong."
      redirect_to :root
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_url
  end
end
