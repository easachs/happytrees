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

  it 'creates new user sad paths with error messages' do
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
    expect(page).to have_content("Username can't be blank")

    # no email
    fill_in :user_username, with: username
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content("Email can't be blank")

    # no password
    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password_confirmation, with: password

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content("Password can't be blank")

    # no confirmation
    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password, with: password

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content("Password confirmation can't be blank, Password confirmation doesn't match Password")

    # different password/confirmation
    fill_in :user_username, with: username
    fill_in :user_email, with: email
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: 'test124'

    click_on 'Create User'

    expect(current_path).to eq('/register')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
