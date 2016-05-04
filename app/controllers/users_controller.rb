class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to :journey_new
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :phone, :contact_pref,
      :password, :password_confirmation, :password_digest
    )
  end
end
