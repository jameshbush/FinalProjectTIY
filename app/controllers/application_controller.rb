class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :dude_wheres_my_record
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
end
