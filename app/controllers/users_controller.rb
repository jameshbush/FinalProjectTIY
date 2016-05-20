class UsersController < ApplicationController
  skip_before_action :require_email_confirmation, only: [:new, :create, :confirm_email]
  skip_before_action :require_quest,              only: [:new, :create, :confirm_email]
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
    if @user.save!
      session[:current_user_id] = @user.id
      UserNotifier.registration_confirmation(@user).deliver_now
      flash[:success] = "New user #{@user.name} created please check your email #{@user.email} and click link."
      if @user.contact_pref == "phone"
        register_authy
      else
        redirect_to @user
      end
    else
      flash.now[:warning] = "Could not save account. Please see #{"error".pluralize(@user.errors.count)} below"
      render :new
    end
  end

  def show
    @reports = active_journey.reports
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User #{current_user.name} updated"
      redirect_to @user
    else
      flash.now[:warning] = "Could not save account. Please see #{"error".pluralize(@user.errors.count)} below"
      render :edit
    end
  end

  def confirm_email
    if current_user
      current_user.email_activate
      session[:current_user_id] = current_user.id
      flash[:success] = "Welcome to the website! Your email has been confirmed.
      You are signed in."
    else
      flash[:error] = "Sorry. User does not exist"
    end
    redirect_to root_url
  end

  private

  def get_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :email, :cellphone, :contact_pref, :name,
      :password, :password_confirmation)
  end

  def register_authy
    authy = Authy::API.register_user(:email => current_user.email, :cellphone => current_user.unamericanized_cell, :country_code => "1")

    if authy.ok?
      current_user.update_attribute(:authy_id, authy.id)
      send_token_id
    else
      authy.errors
      flash[:warning] = "Check your phone number is correct. If that doesn’t work, our phone authentication could be momentarily disabled. Please signup with email or try again later."
      render update_path(current_user)
    end
  end

  def send_token_id
    response = Authy::API.request_sms(:id => current_user.authy_id)

    if response.ok?
      flash[:success] = "User New account created for #{@user.contact_pref == "cellphone" ? @user.cellphone : @user.email} created"
      redirect_to new_phone_verification_path
    else
      response.errors
      flash[:warning] = "Check your phone number is correct. If that doesn’t work, our phone authentication could be momentarily disabled. Please signup with email or try again later."
      render update_path(current_user)
    end
  end
end
