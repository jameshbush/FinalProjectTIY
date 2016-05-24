class PagesController < ApplicationController
  skip_before_action :require_email_confirmation
  skip_before_action :require_quest
  rescue_from ActiveRecord::RecordNotFound, with: :dude_wheres_my_record

  def home
    require_quest if current_user
  end

  def sms_guide
    require_quest if current_user
  end

  def email_guide
    require_quest if current_user
  end
end
