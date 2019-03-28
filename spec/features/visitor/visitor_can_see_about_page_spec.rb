require 'rails_helper'

describe 'as a visitor' do
  it 'can see the about page' do
    visit '/about'

    about_content = "This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel. It's designed for anyone learning how to code, with additional features for current students." # rubocop:disable Metrics/LineLength
    expect(page).to have_content(about_content)
  end
end
