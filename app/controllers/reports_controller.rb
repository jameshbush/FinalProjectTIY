class ReportsController < ApplicationController
  before_action :find_day
  def new
  end

  def create
    @report.survey = params[:report][:survey]
    @report.image  = params[:report][:image]
    @report.save!
    redirect_to user_show_path
  end

  def update
    @report.survey = params[:report][:survey]
    @report.image  = params[:report][:image]
    @report.save!
    redirect_to user_show_path
  end

  private

  def report_params
    params.require(:report).permit(:survey, :image)
  end

  def find_day
    @report = current_user.current_journey.reports.find_or_initialize_by(
    created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end
end
