require 'rails_helper'

describe 'As an admin' do
  it 'I can add a new tutorial' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin) # rubocop:disable Metrics/LineLength

    visit '/admin/tutorials/new'

    thumbnail = 'https://images.theconversation.com/files/133176/original/image-20160804-473-32tg9n.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip' # rubocop:disable Metrics/LineLength

    fill_in 'tutorial[title]', with: 'How to Learn Spanish'
    fill_in 'tutorial[description]', with: 'In only seven days'
    fill_in 'tutorial[thumbnail]', with: thumbnail

    click_on 'Save'

    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial))

    expect(page).to have_content('Successfully created tutorial')
  end
end
