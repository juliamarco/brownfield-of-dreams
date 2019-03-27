class InviteMailer < ApplicationMailer
  def invite(email, inviter_handle, invitee_handle)
    @inviter = inviter_handle
    @invitee = invitee_handle
    mail(to: email, subject: "#{@inviter} has invited you to Brownfield!")
  end
end
