class UserNotifierMailer < ApplicationMailer
  def inform(email, token)
    @token = token
    mail(to: email, subject: 'Account Activation')
  end
end
