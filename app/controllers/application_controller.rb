class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :dude_wheres_my_record
  before_action :require_quest, except: [:new, :create, :edit, :update, :destroy, :home]

  include LoginsHelper
  include ReportsHelper
  include JourneysHelper
  include UsersHelper

  def home
    render 'pages/home'
  end

  def dude_wheres_my_record
    redirect_to current_user
  end

  def require_quest
    user = current_user
    if user.current_journey.nil?
      flash[:warning] = "Please select a quest."
      redirect_to new_user_journey_path(user)
    end
  end
end
