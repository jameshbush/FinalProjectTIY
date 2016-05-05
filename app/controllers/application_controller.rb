class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :require_user, :disallow_user,
                :report_due?

  def home
    render 'pages/home'
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end

  def require_user
    redirect_to :root unless current_user
  end

  def disallow_user
    redirect_to :root if current_user
  end

  def report_due?
    !current_user.current_journey.reports.find_by(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
