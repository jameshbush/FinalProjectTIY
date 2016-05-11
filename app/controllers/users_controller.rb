class UsersController < ApplicationController
  before_action :disallow_user, only: [:new, :create]
  before_action :require_user,  only: [:show, :edit, :update]
  before_action :get_user,      only: [:show, :edit, :update]
  before_action :correct_user,  only: [:show, :edit, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :dude_wheres_my_record

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      if @user.contact_pref == "phone"
        register_authy
      else
        redirect_to :journey_new
      end
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def get_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :email, :cellphone, :contact_pref, :name,
      :password, :password_confirmation, :password_digest
    )
  end

  def register_authy
    authy = Authy::API.register_user(:email => current_user.email, :cellphone => current_user.unamericanized_cell, :country_code => "1")

    if authy.ok?
      current_user.update_attribute(:authy_id, authy.id) # this will give you the user authy id to store it in your database
      send_token_id
    else
      authy.errors # this will return an error hash
      flash["error"] = authy.errors.inspect
      render :new
    end
  end

  def send_token_id
    response = Authy::API.request_sms(:id => current_user.authy_id)

    if response.ok?
      redirect_to new_phone_verification_path
    else
      response.errors
      flash["error"] = response.errors.inspect
      render :new
    end
  end
end
