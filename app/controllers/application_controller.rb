class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include LoginsHelper
  include ReportsHelper
  include JourneysHelper
  include UsersHelper

  def home
    render 'pages/home'
  end
end
