class UserNotifier < ActionMailer::Base
  default :from => 'james_bush@app50574523.bymail.in'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
          :subject => 'Thanks for signing up for our test app' )
  end

  def registration_confirmation(user)
    @user = user
    mail( :to => user.email,
          :subject => 'Registration Confirmation' )
  end

  def reminder_email(user)
    @user = user
    mail(to: user.email,
         subject: "Remember to practice!")
  end
end
