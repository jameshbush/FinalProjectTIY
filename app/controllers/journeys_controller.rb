class JourneysController < ApplicationController
  before_action :require_user
  before_action :correct_user_id,  only: [:show, :edit, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :dude_wheres_my_record

  def new
    @journey = current_user.journeys.new
  end

  def create
    quest = Quest.find_by(grail: params[:journey][:quest])
    if current_user.quests << quest
      reset_journeys
      set_journey
      flash[:success] = "New journey, '#{current_user.grail}' started"
      redirect_to user_path(current_user)
    else
      flash[:warning] = "Please select a journey"
      render :new
    end
  end

  def show
    @reports = active_journey.reports
    @survey_data = @reports.map { |r| { r.created_at.to_date.strftime("%B %d, %Y") => r.survey } }.reduce({}, :merge)
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
