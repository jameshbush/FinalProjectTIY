class EmailProcessor

  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by_email(@email.from[:email])
    report = user.current_report
    img = @email.attachments.first
    txt = Report.parse_text(@email.body)
    report.image  = img if img
    report.survey = txt[:before] if txt[:before]
    report.postsurvey = txt[:after] if txt[:after]
    report.save!
  end
end
