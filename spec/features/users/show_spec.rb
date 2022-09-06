# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User dashboard' do
  it 'show username and email' do
    user = User.create!(username: 'eli', email: 'e@mail.com', password: 'test123', password_confirmation: 'test123')
    visit user_path(user)

    expect(page).to have_content('Username: eli')
    expect(page).to have_content('Email: e@mail.com')
  end
end
