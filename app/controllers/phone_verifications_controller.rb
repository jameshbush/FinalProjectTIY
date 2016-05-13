class PhoneVerificationsController < ApplicationController

  def new
  end

  def create
    response = Authy::API.verify(:id => current_user.authy_id, :token => params[:token][:token])
    puts session.inspect

    if response.ok?
      current_user.phone_verified = true
      current_user.save!
      flash[:success] = "Phone number #{current_user.cellphone} was verified."
      redirect_to user_path(current_user)

    else
      flash.now[:warning] = "Please enter the number texted to #{current_user.cellphone}."
      render :new
    end
  end
end