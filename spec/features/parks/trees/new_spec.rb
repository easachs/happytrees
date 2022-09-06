# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create Tree' do
  it 'can create new park tree' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}/trees/new"
    fill_in 'Species', with: 'Siberian Elm'
    fill_in 'Diameter', with: '40'
    check 'Healthy'
    click_button 'Create Tree'

    expect(current_path).to eq("/parks/#{park.id}/trees")
    expect(page).to have_content('Siberian Elm')
    expect(page).to have_content('40')
    expect(page).to have_content('Healthy')
  end
end
