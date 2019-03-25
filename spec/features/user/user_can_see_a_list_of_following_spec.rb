require 'rails_helper'

describe "User" do
  it 'can see a list of following' do
    user_1 = create(:user, uid: "1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    VCR.use_cassette("github_service") do
      visit dashboard_path

      expect(page).to have_css("#following")
      expect(page).to have_content("Following")

      within "#following" do
        expect(page).to have_css(".user")
        within(first(".user")) do
          expect(page).to have_css(".handle")
        end

        url = "https://github.com/juliamarco"
        expect(page).to have_link("juliamarco", href: url)
      end
    end
  end
end
