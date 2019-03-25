require 'rails_helper'

describe 'User' do
  it 'when I visit the dashboard I see a list of 5 repos' do
    user = create(:user, uid: "1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("github_service") do
      visit '/dashboard'

      expect(page).to have_css("#Github")
      expect(page).to have_content("Github")

      within "#Github" do
        expect(page).to have_css(".repository", count: 5)
        within "#repositories" do
          expect(page).to have_css(".name")

          url = "https://github.com/timnallen/activerecord-obstacle-course"

          expect(page).to have_link("activerecord-obstacle-course", href: url)
        end
      end
    end
  end

  it 'shows the proper repositories when there are more than one user in the database with different tokens' do
    user = create(:user, access_token: ENV["AT_2"], uid: "1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("github_service_2") do
      visit '/dashboard'

      expect(page).to have_css("#Github")
      expect(page).to have_content("Github")

      within "#Github" do
        expect(page).to have_css(".repository", count: 5)
        expect(page).to have_css(".name")

        url_1 = "https://github.com/juliamarco/activerecord-obstacle-course"
        url_2 = "https://github.com/timnallen/activerecord_exploration"

        expect(page).to_not have_link("activerecord_exploration", href: url_2)
        expect(page).to have_link("activerecord-obstacle-course", href: url_1)
      end
    end
  end

  it 'does not show a github section without an access token' do
    user = create(:user, access_token: nil)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_css('#Github')
  end
end
