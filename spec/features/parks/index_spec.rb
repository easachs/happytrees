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

  it 'orders parks by most recent first' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    park_3 = Park.create!(name: "Morse", affluent: false, year: 1960)
    visit "/parks"

    within '#park_0' do
      expect(page).to have_content(park_3.name)
    end

    within '#park_2' do
      expect(page).to have_content(park_1.name)
    end
  end

  it 'shows when created' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks"

    expect(page).to have_content("Created: #{park_1.created_at}")
    expect(page).to have_content("Created: #{park_2.created_at}")
  end

  # User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index

  it 'has link to tree index' do
    visit "/parks"
    expect(page).to have_link('Trees Index')
    click_link 'Trees Index'
    expect(current_path).to eq("/trees")
  end

  # User Story 9, Parent Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Parent Index

  it 'has link to park index' do
    visit "/parks"
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq("/parks")
  end

  # User Story 11, Parent Creation 

  # As a visitor
  # When I visit the Parent Index page
  # Then I see a link to create a new Parent record, "New Parent"
  # When I click this link
  # Then I am taken to '/parents/new' where I  see a form for a new parent record
  # When I fill out the form with a new parent's attributes:
  # And I click the button "Create Parent" to submit the form
  # Then a `POST` request is sent to the '/parents' route,
  # a new parent record is created,
  # and I am redirected to the Parent Index page where I see the new Parent displayed.

  it 'has link to create new park' do
    visit "/parks"
    expect(page).to have_link('New Park')
    click_link 'New Park'
    expect(current_path).to eq("/parks/new")
  end
end