class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by_email(@email.from[:email])
    @report = user.current_journey.reports.find_or_initialize_by(
    created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    img = @email.attachments.first
    txt = @email.body
    Rails.logger.info @email.inspect
    @report.image  = img if img
    @report.survey = txt if txt
    @report.save!
  end
end
