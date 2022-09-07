# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login' do
  it 'can log in a user' do
    user = User.create!(username: 'eli', email: 'e@mail.com', password: 'test123', password_confirmation: 'test123')

    visit root_path

    click_link 'Log In'

    expect(current_path).to eq(login_path)

    email = 'e@mail.com'
    password = 'test123'

    fill_in :email, with: email
    fill_in :password, with: password

    click_button 'Log In'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome, #{user.username}!")
  end

  it 'cant login with bad credentials' do
    User.create!(username: 'eli', email: 'e@mail.com', password: 'test123', password_confirmation: 'test123')

    visit login_path

    email = 'e@mail.com'

    fill_in :email, with: email
    fill_in :password, with: 'test124'

    click_button 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Invalid credentials. Please try again.')
  end
end
