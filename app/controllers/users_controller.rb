class UsersController < ApplicationController
  skip_before_action :require_email_confirmation, only: [:new, :create, :confirm_email]
  skip_before_action :require_quest,              only: [:new, :create, :confirm_email]
  before_action :require_cellphone,               only: [:show]
  before_action :disallow_user, only: [:new, :create]
  before_action :require_user,  only: [:show, :edit, :update]
  before_action :get_user,      only: [:show, :edit, :update]
  before_action :correct_user,  only: [:show, :edit, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :dude_wheres_my_record

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      UserNotifier.registration_confirmation(@user).deliver_now
      flash[:success] = "New user #{@user.name} created please check your email #{@user.email} and click link."
      if @user.contact_pref == "phone"
        register_authy
      else
        redirect_to @user
      end
    else
      flash.now[:warning] = "Could not save account. Please see #{"error".pluralize(@user.errors.count)} below"
      render :new
    end
  end

  def show
    @reports = current_user.current_journey.reports
    survey_data =      { name: 'PreSurvey', data: @reports.map { |r| { r.created_at.to_date.strftime("%B %d, %Y") => r.survey } }.reduce({}, :merge) }
    postsurvey_data =  { name: 'PostSurvey', data: @reports.map { |r| { r.created_at.to_date.strftime("%B %d, %Y") => r.postsurvey } }.reduce({}, :merge) }
    @survey_data = [survey_data, postsurvey_data]
  end

  def edit
  end

  def update
    email = @user.email
    cellphone = @user.cellphone
    if @user.update(user_params)
      flash[:success] = "User #{current_user.name} updated"
      redirect_to @user
      @user.update_attribute(:phone_verified, false) unless(@user.cellphone == cellphone || @user.cellphone == "")
      @user.update_attribute(:email_verified, false) unless(@user.email == email || @user.email == "")
    else
      flash.now[:warning] = "Could not save account. Please see #{"error".pluralize(@user.errors.count)} below"
      render :edit
    end
  end

  private

  def get_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :email, :cellphone, :contact_pref, :name,
      :password, :password_confirmation)
  end
end
