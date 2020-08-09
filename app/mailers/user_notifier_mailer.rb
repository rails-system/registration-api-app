class UserNotifierMailer < ApplicationMailer
  default from: 'test050800@yopmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def verify_email_otp(user)
    @user = user
    mail( to: @user.email, subject: 'Thanks for signing up for app' )
  end
end