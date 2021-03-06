require 'rails_helper'

describe 'As a registered user' do # rubocop:disable Metrics/BlockLength
  before :each do
    user_1 = create(:user, uid: '1')
    user_2 = create(:user,
                    uid: '35079289',
                    access_token: ENV['AT_2'],
                    handle: 'juliamarco')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1) # rubocop:disable Metrics/LineLength
  end

  it 'lets me add another registered user as a friend' do
    VCR.use_cassette('github_service') do
      visit dashboard_path

      within('#Github') do
        within(all('.follower').last) do
          expect(page).to have_content('Add as Friend')
        end

        within(first('.follower')) do
          expect(page).to_not have_content('Add as Friend')
        end

        within(first('.user')) do
          expect(page).to_not have_content('Add as Friend')
        end

        within(all('.user')[4]) do
          click_on 'Add as Friend'
        end
      end

      expect(page).to have_css('#Friends', count: 1)
      within(first('.friend')) do
        expect(page).to have_content('juliamarco')
      end
    end
  end

  it "won't let me add a friend with missing info" do
    VCR.use_cassette('github_service') do
      allow_any_instance_of(Friendship).to receive(:save).and_return(false)

      visit dashboard_path

      within(all('.user')[4]) do
        click_on 'Add as Friend'
      end

      expect(page).to have_content('This friendship could not be created')
      expect(current_path).to eq(dashboard_path)
    end
  end
end
