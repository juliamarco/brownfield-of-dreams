require 'rails_helper'

RSpec.describe UserNotifierMailer, type: :mailer do
  describe 'registration_email' do
    let(:user) do
      mock_model User, first_name: 'Lucas',
                       email: 'lucas@email.com',
                       temporary_token: '12345678'
    end

    let(:mail) { UserNotifierMailer.inform(user.email, user.temporary_token).deliver_now } # rubocop:disable Metrics/LineLength

    it 'renders the subject' do
      expect(mail.subject).to eq('Account Activation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@brownfield.com'])
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to include("/activation?token=#{user.temporary_token}")
    end
  end
end
