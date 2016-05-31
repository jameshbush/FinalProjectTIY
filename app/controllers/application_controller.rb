class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :dude_wheres_my_record
  before_action :require_email_confirmation, except: [:new, :create]
  before_action :require_cellphone,          except: [:new, :create, :edit, :update, :destroy]
  before_action :require_quest,              except: [:new, :create, :edit, :update, :destroy]

  include LoginsHelper
  include UsersHelper

  def dude_wheres_my_record
    redirect_to current_user if params[:current_user_id]
    render nothing: true     if params["From"]
  end

  def require_quest
    if current_user && (current_user.current_journey.nil? || current_user.current_journey.quest.nil?)
      flash[:warning] = "Please select a quest."
      redirect_to new_user_journey_path(current_user) and return
    end
  end

  # Cellphone Confirmation
  def require_cellphone
    if current_user && !current_user.phone_verified && !current_user.cellphone.blank?
      flash[:warning] = "We need to verify your cellphone number."
      register_authy
    end
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
      flash[:success] = "User New account created for #{current_user.contact_pref == "cellphone" ? current_user.cellphone : current_user.email} created"
      redirect_to new_phone_verification_path
    else
      response.errors
      flash[:warning] = "Check your phone number is correct. If that doesn’t work, our phone authentication could be momentarily disabled. Please signup with email or try again later."
      render update_path(current_user)
    end
  end

  # Email Confirmation
  def require_email_confirmation
    unless current_user.email_verified
      flash[:warning] = "We emailed #{current_user.email} to verify your account."
      redirect_to :root
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
end
