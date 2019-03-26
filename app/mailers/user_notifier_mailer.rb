class UserNotifierMailer < ApplicationMailer
  def inform(email)
    mail(to: email, subject: 'Account Activation')
  end
end
