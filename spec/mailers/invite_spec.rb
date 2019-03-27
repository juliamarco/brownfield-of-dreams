require 'rails_helper'

RSpec.describe InviteMailer, type: :mailer do
  describe 'registration_email' do
    let(:mail) { InviteMailer.invite('1234+fakeuser@noreply.github.com', 'timnallen', 'fakeuser').deliver_now } # rubocop:disable Metrics/LineLength

    it 'renders the subject' do
      expect(mail.subject).to eq('timnallen has invited you to Brownfield!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq(['1234+fakeuser@noreply.github.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['no-reply@brownfield.com'])
    end
  end
end
