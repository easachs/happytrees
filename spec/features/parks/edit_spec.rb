# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit Park' do
  it 'can update park' do
    park = Park.create!(name: 'Turtle Park', affluent: false, year: 1950)
    visit "/parks/#{park.id}/edit"
    fill_in 'Name', with: 'Sloans Lake'
    fill_in 'Year', with: '1940'
    check 'Affluent'
    click_button 'Update Park'

    expect(current_path).to eq("/parks/#{park.id}")
    expect(page).to have_content('Sloans Lake')
    expect(page).to have_content('1940')
    expect(page).to have_content('Affluent')
  end
end
