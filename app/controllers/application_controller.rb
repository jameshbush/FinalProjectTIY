class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :dude_wheres_my_record
  before_action :require_cellphone, except: [:new, :create, :edit, :update, :destroy, :home]
  before_action :require_quest, except: [:new, :create, :edit, :update, :destroy, :home]

  include LoginsHelper
  include ReportsHelper
  include JourneysHelper
  include UsersHelper

  def home
    render 'pages/home'
  end

  def dude_wheres_my_record
    redirect_to current_user if params[:current_user_id]
    render nothing: true     if params["From"]
  end

  def require_quest
    if current_user.current_journey.nil?
      flash[:warning] = "Please select a quest."
      redirect_to new_user_journey_path(current_user)
    end
  end

  def require_cellphone
    if current_user.contact_pref == "phone" && current_user.phone_verified.nil?
      flash[:warning] = "We need to verify your cellphone number."
      register_authy
    end
  end
end
