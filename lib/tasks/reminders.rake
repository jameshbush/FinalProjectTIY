notification = "You should think about doing your exercise."

def send_message(phone_number, alert_message)

  @twilio_number = ENV['TWILIO_NUMBER']
  @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

  message = @client.account.messages.create(
    :from => @twilio_number,
    :to => "+1" + phone_number,
    :body => alert_message,
    # US phone numbers can make use of an image as well.
    # :media_url => image_url
  )
  puts message.to
end


task remind: :environment do
  @users_to_contact = User.has_current_journey.prefer_phone_scope
  @users_to_contact.each{ |user| send_message(user.phone, notification) }
end
