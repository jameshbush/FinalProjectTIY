class LoginsController < ApplicationController
  before_action :disallow_user, only: [:new, :create]
  before_action :require_user,  only: [:distroy]
  skip_before_action :require_email_confirmation

  def new
  end

  def create
    @user = User.find_by(email: params[:login][:email])
    if @user && @user.authenticate(params[:login][:password])
      if @user.email_verified
        session[:current_user_id] = @user.id
        flash[:success] = "You logged in!"
        redirect_back_or @user
      else
        flash[:warning] = "Please confirm your email account."
        render :new
      end
    else
      flash[:error] = "Email or password wrong."
      redirect_to :root
    end
  end

  def destroy
    session[:current_user_id] = nil
    flash[:success] = "You successfully logged out."
    redirect_to root_url
  end
end
