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
end