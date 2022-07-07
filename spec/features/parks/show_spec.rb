require 'rails_helper'

RSpec.describe 'Park Show' do

  # User Story 2, Parent Show 

  # As a visitor
  # When I visit '/parents/:id'
  # Then I see the parent with that id including the parent's attributes:
  # - data from each column that is on the parent table

  it 'displays park name' do
    park_1 = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks/#{park_1.id}"

    expect(page).to have_content(park_1.name)
    expect(page).to_not have_content(park_2.name)
  end

  it 'displays park attributes' do
    park_1 = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks/#{park_1.id}"

    expect(page).to have_content("Established: #{park_1.year}")
    expect(page).to have_content("Affluent")
  end

  # User Story 7, Parent Child Count

  # As a visitor
  # When I visit a parent's show page
  # I see a count of the number of children associated with this parent

  it 'shows tree count' do
    park_1 = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    park_1.trees.create(species: "Spruce", healthy: true, diameter: 28)
    park_1.trees.create(species: "Elm", healthy: true, diameter: 22)
    park_1.trees.create(species: "Oak", healthy: false, diameter: 25)
    visit "/parks/#{park_1.id}"

    expect(page).to have_content("Tree Count: #{park_1.trees.count}")
    expect(page).to have_content("Tree Count: 3")
  end
end