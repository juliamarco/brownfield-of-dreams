require 'rails_helper'

describe 'as a visitor' do
  it 'cannot see classroom tutorials index' do
    tutorial_1 = create(:tutorial, title: 'How to bark', classroom: true)
    tutorial_2 = create(:tutorial, title: 'How to survive Turing')

    visit root_path

    expect(page).to have_content(tutorial_2.title)
    expect(page).to_not have_content(tutorial_1.title)

    visit tutorials_path

    expect(page).to have_content(tutorial_2.title)
    expect(page).to_not have_content(tutorial_1.title)
  end

  it 'cannot see a specific classroom tutorial' do
    tutorial_1 = create(:tutorial, title: 'How to bark', classroom: true)
    tutorial_2 = create(:tutorial, title: 'How to survive Turing')

    visit tutorial_path(tutorial_1)

    expect(page).to have_content('You have to register to access this tutorial')

    visit tutorial_path(tutorial_2)

    expect(page).to have_content(tutorial_2.title)
  end
end
