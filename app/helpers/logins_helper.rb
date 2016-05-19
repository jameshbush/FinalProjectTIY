module LoginsHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user
    if session[:current_user_id]
      @current_user ||= User.find_by_id(session[:current_user_id])
    elsif params["From"]
      @current_user ||= User.find_by(cellphone: params["From"])
    elsif params["action"] == "confirm_email"
      @current_user ||= User.find_by(confirm_token: params[:id])
    end
  end

  def require_user
    unless current_user
      store_location
      redirect_to login_path
    end
  end

  def disallow_user
    redirect_to :root if current_user
  end

  def redirect_back_or(default=root_url)
      redirect_to(session[:redirect_to] || default)
      session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
