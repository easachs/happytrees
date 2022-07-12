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

  # User Story 17, Parent Update From Parent Index Page 

  # As a visitor
  # When I visit the parent index page
  # Next to every parent, I see a link to edit that parent's info
  # When I click the link
  # I should be taken to that parents edit page where I can update its information just like in User Story 4

  it 'has links to edit parks' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks"

    within '#park_0' do
      # most recent first
      expect(page).to have_content("#{park_2.name}")
      expect(page).to have_link('Edit')
    end

    within '#park_1' do
      expect(page).to have_content("#{park_1.name}")
      expect(page).to have_link('Edit')
      click_link 'Edit'
      expect(current_path).to eq("/parks/#{park_1.id}/edit")
    end
  end

  # User Story 22, Parent Delete From Parent Index Page 

  # As a visitor
  # When I visit the parent index page
  # Next to every parent, I see a link to delete that parent
  # When I click the link
  # I am returned to the Parent Index Page where I no longer see that parent

  it 'has link to delete next to each park' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks"

    within '#park_0' do
      # most recent first
      expect(page).to have_content("#{park_2.name}")
      expect(page).to have_link('Delete')
    end

    within '#park_1' do
      expect(page).to have_content("#{park_1.name}")
      expect(page).to have_link('Delete')
      click_link 'Delete'
    end

    expect(current_path).to eq("/parks")
    expect(page).to have_content("#{park_2.name}")
    expect(page).to_not have_content("#{park_1.name}")
  end

  # Sort Parents by Number of Children 

  # As a visitor
  # When I visit the Parents Index Page
  # Then I see a link to sort parents by the number of `child_table_name` they have
  # When I click on the link
  # I'm taken back to the Parent Index Page where I see all of the parents in order of their count of `child_table_name` (highest to lowest) And, I see the number of children next to each parent name

  it 'can sort parks by tree count' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    tree_1 = park_2.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park_2.trees.create!(species: "Elm", healthy: true, diameter: 28)
    park_3 = Park.create!(name: "Morse", affluent: false, year: 1960)
    tree_3 = park_3.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/parks"

    # most recent first
    within '#park_0' do
      expect(page).to have_content(park_3.name)
    end

    within '#park_2' do
      expect(page).to have_content(park_1.name)
    end

    expect(page).to have_link('Sort By Tree Count')
    click_link 'Sort By Tree Count'
    expect(page).to have_current_path("/parks?sort=treecount")

    within '#park_0' do
      expect(page).to have_content(park_2.name)
    end

    within '#park_1' do
      expect(page).to have_content(park_3.name)
    end

    within '#park_2' do
      expect(page).to have_content(park_1.name)
    end
  end

  it 'has links to each park show page' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    visit "/parks"

    within '#park_0' do
      # most recent first
      expect(page).to have_link("#{park_2.name}")
    end

    within '#park_1' do
      expect(page).to have_link("#{park_1.name}")
      click_link "#{park_1.name}"
      expect(current_path).to eq("/parks/#{park_1.id}")
    end
  end

  # Search by name (exact match)

  # As a visitor
  # When I visit an index page ('/parents') or ('/child_table_name')
  # Then I see a text box to filter results by keyword
  # When I type in a keyword that is an exact match of one or more of my records and press the Search button
  # Then I only see records that are an exact match returned on the page

  it 'has search textbox and can search by exact name' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    park_3 = Park.create!(name: "Morse", affluent: false, year: 1960)
    visit "/parks"

    fill_in 'Exact search', with: 'Turtle'
    expect(page).to have_button('Exact Search')
    click_button 'Exact Search'

    expect(page).to have_current_path("/parks?exact_search=Turtle")
    expect(page).to have_content(park_1.name)
    expect(page).to_not have_content(park_2.name)
    expect(page).to_not have_content(park_3.name)
  end

  # Search by name (partial match)

  # As a visitor
  # When I visit an index page ('/parents') or ('/child_table_name')
  # Then I see a text box to filter results by keyword
  # When I type in a keyword that is an partial match of one or more of my records and press the Search button
  # Then I only see records that are an partial match returned on the page

  it 'has search textbox and can search by partial name' do
    park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
    park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
    park_3 = Park.create!(name: "Moore", affluent: false, year: 1960)
    visit "/parks"

    fill_in 'Partial search', with: 'oo'
    expect(page).to have_button('Partial Search')
    click_button 'Partial Search'

    expect(page).to have_current_path("/parks?partial_search=oo")
    expect(page).to have_content(park_2.name)
    expect(page).to have_content(park_3.name)
    expect(page).to_not have_content(park_1.name)
  end
end