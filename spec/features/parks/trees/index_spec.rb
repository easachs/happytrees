require 'rails_helper'

RSpec.describe 'Park Trees Index' do
  
  # User Story 5, Parent Children Index 

  # As a visitor
  # When I visit '/parents/:parent_id/child_table_name'
  # Then I see each Child that is associated with that Parent with each Child's attributes:

  it 'displays park name' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks/#{park_1.id}/trees"

    expect(page).to have_content(park_1.name)
    expect(page).to_not have_content(park_2.name)
  end

  it 'displays tree species and attributes' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/parks/#{park.id}/trees"

    expect(page).to have_content(tree_1.species)
    expect(page).to have_content("Diameter: #{tree_1.diameter} in")
    expect(page).to have_content("Healthy")
    expect(page).to have_content(tree_2.species)
    expect(page).to have_content("Diameter: #{tree_2.diameter} in")
    expect(page).to_not have_content("Unhealthy")
  end
end