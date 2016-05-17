class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by_email(@email.from[:email])
    report = user.current_report
    img = @email.attachments.first
    txt = @email.body
    report.image  = img if img
    report.survey = txt if txt
    report.save!
  end
end
