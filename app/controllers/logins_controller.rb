class LoginsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:login][:email])
    if @user && @user.authenticate(params[:login][:password])
      session[:current_user_id] = @user.id
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_url
  end
end
