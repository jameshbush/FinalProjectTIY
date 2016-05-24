notification = "You should think about doing your exercise. Find sms upload instructions at happenstance.herokuapp.com/text-guide."

def send_message(phone_number, alert_message)

  @twilio_number = ENV['TWILIO_NUMBER']
  @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

  message = @client.account.messages.create(
    :from => @twilio_number,
    :to => phone_number,
    :body => alert_message,
  )
  puts message.to
end

def send_email(user)
  UserNotifier.reminder_email(user).deliver_now
end

task remind: :environment do
  @users_to_contact = User.has_current_journey.prefer_phone_scope
  @users_to_contact.each{ |user| send_message(user.cellphone, notification) }
  @users_to_contact = User.has_current_journey.prefer_email_scope
  @users_to_contact.each{ |user| send_email(user) }
end

task reprimand: :environment do
  User.all.each do |user|
    user.current_report.save!
  end
end
