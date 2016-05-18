class EmailProcessor
  skip_before_filter :verify_authenticity_token, :require_cellphone, :require_quest, :require_email_confirmation

  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by_email(@email.from[:email])
    report = user.current_report
    img = @email.attachments.first
    txt = Report.parse_text(@email.body)
    report.image  = img if img
    report.survey = txt if txt
    report.save!
  end
end
