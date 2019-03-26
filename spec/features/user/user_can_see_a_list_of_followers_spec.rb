require 'rails_helper'

describe 'User' do
  it 'can see a list of followers' do
    user_1 = create(:user, uid: '1')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1) # rubocop:disable Metrics/LineLength

    VCR.use_cassette('github_service') do
      visit dashboard_path

      expect(page).to have_css('#followers')
      expect(page).to have_content('Followers')

      within '#followers' do
        expect(page).to have_css('.follower')
        within(first('.follower')) do
          expect(page).to have_css('.handle')
        end

        url = 'https://github.com/juliamarco'
        expect(page).to have_link('juliamarco', href: url)
      end
    end
  end
end
