class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def welcome_email(user)
    @user = user
    @login_url = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to Our Social Media Site!')
  end
end
