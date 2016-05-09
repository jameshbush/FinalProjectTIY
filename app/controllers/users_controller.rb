class UsersController < ApplicationController
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
      redirect_to :journey_new
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def get_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :email, :phone, :contact_pref, :name,
      :password, :password_confirmation, :password_digest
    )
  end
end
