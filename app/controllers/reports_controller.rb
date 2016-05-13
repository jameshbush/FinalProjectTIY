class ReportsController < ApplicationController
  before_action :find_day
  before_action :correct_user_id, except: [:create_from_sms]
  skip_before_filter :verify_authenticity_token, :require_cellphone, :require_quest, only: [:create_from_sms]
  rescue_from ActiveRecord::RecordNotFound, with: :dude_wheres_my_record

  def new
  end

  def create
    if @report.update_attributes(report_params)
      redirect_to user_journey_path(id: current_user.id)
    else
      render :create
    end
  end

  def update
    if @report.update_attributes(report_params)
      redirect_to user_journey_path
    else
      render :update
    end
  end

  def create_from_sms
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @twilio_number = ENV['TWILIO_NUMBER']
    img = params['MediaUrl0']
    txt = params["Body"]
    @report.image = open(params["MediaUrl0"], allow_redirections: :all) if img
    @report.survey = params["Body"] unless txt.empty?

    if @report.save
      @client.messages.create(
        from: @twilio_number,
        to: current_user.cellphone,
        body: "We got the#{' img' if img}#{' &' if(img && txt)}#{' survey' unless txt.empty?}."
      )
    else
      @client.messages.create(
        from: @twilio_number,
        to: current_user.cellphone,
        body: "Didn't get that."
      )
    end
    render nothing: true
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
