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
    redirect_to :root unless current_user
  end

  def disallow_user
    redirect_to :root if current_user
  end
end
