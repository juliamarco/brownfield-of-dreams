require 'rails_helper'

describe 'as a user' do
  before :each do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) # rubocop:disable Metrics/LineLength
  end

  it 'shows me buttons to invite people to become users' do
    visit dashboard_path

    click_on 'Send an Invite'

    expect(current_path).to eq('/invite')

    fill_in :github_handle, with: 'timnallen'

    VCR.use_cassette('github service user') do
      click_on 'Send Invite'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content('Successfully sent invite!')
    end
  end

  it 'will let me know if a github handle is incorrect' do
    visit '/invite'

    fill_in :github_handle, with: 'hbfudiosduykfkwbfgudiks'

    VCR.use_cassette('sad github') do
      click_on 'Send Invite'

      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.") # rubocop:disable Metrics/LineLength
    end
  end
end
