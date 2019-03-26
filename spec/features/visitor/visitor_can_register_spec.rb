require 'rails_helper'

describe 'visitor can create an account', :js do # rubocop:disable Metrics/BlockLength, Metrics/LineLength
  it ' visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Submit'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
  end

  it 'cannot create an account with the same username' do
    email = 'jimbob@aol.com'
    create(:user, email: email)
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Submit'

    expect(page).to have_content('Username already exists')
  end

  it 'allows me to register as a new user' do
    email = 'myname@gmail.com'
    first_name = 'Tim'
    last_name = 'Jr'
    password = 'password'

    visit '/'

    click_on 'Register'

    expect(current_path).to eq('/register')

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Submit'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content('Logged in as Tim Jr')

    expect(page).to have_content('This account has not yet been activated. Please check your email.') # rubocop:disable Metrics/LineLength
  end

  it 'activates my account through email' do
  end
end
