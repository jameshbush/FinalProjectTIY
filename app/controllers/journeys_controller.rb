class JourneysController < ApplicationController
  before_action :require_user

  def new
  end

  def create
    quest = Quest.find_by(grail: params[:journey][:quest])
    if current_user.quests << quest
      reset_journeys
      set_journey
      redirect_to user_show_path
    else
      render :new
    end
  end

  private

  def reset_journeys
    current_user.journeys.each do |q|
      q.current = false
      q.save!
    end
  end

  def set_journey
    current_user.journeys.last.current = true
    current_user.journeys.last.save!
  end

  def journey_params
    params.require(:quest).premit(:user_id, :quest_id)
  end
end
