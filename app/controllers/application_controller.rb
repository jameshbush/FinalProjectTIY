class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :report_due?, :active_journey, :active_report
  include LoginsHelper

  def home
    render 'pages/home'
  end

  def active_journey
    @active_journey ||= current_user.current_journey
  end

  def report_due?
    !active_journey.reports.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def active_report
    active_journey.reports.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
