require 'rails_helper'

RSpec.describe 'Park Index' do

  # User Story 1, Parent Index 

  # For each parent table
  # As a visitor
  # When I visit '/parents'
  # Then I see the name of each parent record in the system

  it 'displays park name' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks"

    expect(page).to have_content(park_1.name)
    expect(page).to have_content(park_2.name)
  end

  # User Story 6, Parent Index sorted by Most Recently Created 

  # As a visitor
  # When I visit the parent index,
  # I see that records are ordered by most recently created first
  # And next to each of the records I see when it was created

  xit 'orders parks by most recent first' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    park_3 = Park.create!(name: "Morse", affluent: false, year: 1960)
    visit "/parks"

    expect(page.all('.park').first).to have_content(park_3.name)
    expect(page.all('.park').last).to have_content(park_1.name)
  end

  it 'shows when created' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks"

    expect(page).to have_content("Created: #{park_1.created_at}")
    expect(page).to have_content("Created: #{park_2.created_at}")
  end
end