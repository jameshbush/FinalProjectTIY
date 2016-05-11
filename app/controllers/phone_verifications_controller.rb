class PhoneVerificationsController < ApplicationController

  def new
  end

  def create
    response = Authy::API.verify(:id => current_user.authy_id, :token => params[:token][:token])
    puts session.inspect

    if response.ok?
      redirect_to :journey_new

    else
      render :new
    end
  end
end
