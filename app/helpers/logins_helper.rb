module LoginsHelper
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
end
