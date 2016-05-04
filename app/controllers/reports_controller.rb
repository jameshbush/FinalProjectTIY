class ReportsController < ApplicationController

  def new
    @report = current_user.current_journey.reports.find_or_initialize_by(
      created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    )
  end

  def create
    @report = current_user.current_journey.reports.find_or_initialize_by(
      created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    )
    @report.survey = params[:report][:survey]
    @report.save!
    redirect_to user_show_path
  end

  def update
    @report = current_user.current_journey.reports.find_or_initialize_by(
      created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    )
    @report.survey = params[:report][:survey]
    @report.save!
    redirect_to user_show_path
  end

  private

  def report_params
    params.require(:report).permit(:survey)
  end
end
