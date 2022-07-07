require 'rails_helper'

RSpec.describe 'Tree Index' do

  # User Story 3, Child Index 

  # As a visitor
  # When I visit '/child_table_name'
  # Then I see each Child in the system including the Child's attributes:

  it 'displays tree species' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/trees"

    expect(page).to have_content(tree_1.species)
    expect(page).to have_content("Diameter: #{tree_1.diameter} in")
    expect(page).to have_content("Healthy")
    expect(page).to have_content(tree_2.species)
    expect(page).to have_content("Diameter: #{tree_2.diameter} in")
    expect(page).to_not have_content("Unhealthy")
  end
end