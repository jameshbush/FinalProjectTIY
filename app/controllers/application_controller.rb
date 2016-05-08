class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :report_due?, :active_journey, :active_report
  include LoginsHelper
  include ReportsHelper

  def home
    render 'pages/home'
  end

  def active_journey
    @active_journey ||= current_user.current_journey
  end
end
