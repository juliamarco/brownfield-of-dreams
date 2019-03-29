require 'rails_helper'

describe 'As an admin' do
  before :each do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin) # rubocop:disable Metrics/LineLength
  end

  it 'I can add a new tutorial' do
    visit new_admin_tutorial_path

    thumbnail = 'https://images.theconversation.com/files/133176/original/image-20160804-473-32tg9n.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip' # rubocop:disable Metrics/LineLength

    fill_in 'tutorial[title]', with: 'How to Learn Spanish'
    fill_in 'tutorial[description]', with: 'In only seven days'
    fill_in 'tutorial[thumbnail]', with: thumbnail

    click_on 'Save'

    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial))

    expect(page).to have_content('Successfully created tutorial')
  end

  it 'cannot add a tutorial if there is missing info' do
    visit '/admin/tutorials/new'

    fill_in 'tutorial[title]', with: 'hi'

    click_on 'Save'

    expect(page).to have_button('Save')
  end
end
