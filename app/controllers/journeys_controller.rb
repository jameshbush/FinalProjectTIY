class JourneysController < ApplicationController

  before_action :require_user

  def new
  end

  def create
    quest = Quest.find_by(grail: params[:journey][:quest])
    if current_user.quests << quest
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def journey_params
    params.require(:quest).premit(:user_id, :quest_id)
  end
end
