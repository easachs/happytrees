# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User registration' do
  it 'creates new user' do
    visit root_path

    click_on 'Register User'

    expect(current_path).to eq('/register')

    username = 'eli'
    email = 'e@mail.com'
    password = 'test123'

    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on 'Create User'

    expect(page).to have_content("Welcome, #{username}!")
    expect(User.last.username).to eq('eli')
    expect(User.last.email).to eq('e@mail.com')
    expect(User.last).to_not have_attribute(:password)
    expect(User.last.password_digest).to_not eq(password)
  end

  it 'creates new user sad paths' do
    visit '/register'

    username = 'eli'
    email = 'e@mail.com'
    password = 'test123'

    # no username
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content('Invalid. Please try again.')

    # no email
    fill_in :user_username, with: username
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content('Invalid. Please try again.')

    # no password
    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password_confirmation, with: password

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content('Invalid. Please try again.')

    # no confirmation
    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password, with: password

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content('Invalid. Please try again.')

    # different password/confirmation
    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: 'test124'

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content('Invalid. Please try again.')
  end
end
