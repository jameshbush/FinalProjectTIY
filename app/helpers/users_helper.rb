module UsersHelper
  def correct_user
    @user = User.find(params[:id])
    redirect_to(current_user || root_url) unless current_user == @user
  end

  def correct_user_id
    @user = User.find(params[:user_id])
    redirect_to(current_user || root_url) unless current_user == @user
  end
end
