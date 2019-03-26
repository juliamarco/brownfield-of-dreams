require 'rails_helper'

describe 'as a user' do
  it 'can see a specific classroom tutorial' do
    user = create(:user)
    tutorial_1 = create(:tutorial, title: 'How to bark', classroom: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) # rubocop:disable Metrics/LineLength

    visit tutorial_path(tutorial_1)

    expect(page).to have_css('.tutorials')
    expect(page).to have_content('Videos')
  end
end
