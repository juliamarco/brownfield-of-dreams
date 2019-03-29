require 'rails_helper'

describe 'as a visitor' do
  it 'can see a get started page' do
    visit '/get_started'

    expect(page).to have_content('Browse tutorials from the homepage.')
  end
end
