# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit Tree' do
  it 'can update tree' do
    park = Park.create!(name: 'Turtle Park', affluent: false, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    visit "/trees/#{tree1.id}/edit"
    fill_in 'Species', with: 'Catalpa'
    fill_in 'Diameter', with: '30'
    click_button 'Update Tree'

    expect(current_path).to eq("/trees/#{tree1.id}")
    expect(page).to have_content('Catalpa')
    expect(page).to have_content('30')
    expect(page).to have_content('Unhealthy')
  end
end
