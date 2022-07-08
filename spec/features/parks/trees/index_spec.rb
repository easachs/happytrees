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

  # User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index

  it 'has link to tree index' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    visit "/parks/#{park.id}/trees"
    expect(page).to have_link('Trees Index')
    click_link 'Trees Index'
    expect(current_path).to eq("/trees")
  end

  # User Story 9, Parent Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Parent Index

  it 'has link to park index' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    visit "/parks/#{park.id}/trees"
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq("/parks")
  end

  # User Story 13, Parent Child Creation 

  # As a visitor
  # When I visit a Parent Childs Index page
  # Then I see a link to add a new adoptable child for that parent "Create Child"
  # When I click the link
  # I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
  # When I fill in the form with the child's attributes:
  # And I click the button "Create Child"
  # Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
  # a new child object/row is created for that parent,
  # and I am redirected to the Parent Childs Index page where I can see the new child listed

  it 'has link to create new tree' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    visit "/parks/#{park.id}/trees"
    expect(page).to have_link('Create Tree')
    click_link 'Create Tree'
    expect(current_path).to eq("/parks/#{park.id}/trees/new")
  end

  # User Story 16, Sort Parent's Children in Alphabetical Order by name 

  # As a visitor
  # When I visit the Parent's children Index Page
  # Then I see a link to sort children in alphabetical order
  # When I click on the link
  # I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order

  it 'has link to sort trees alphabetically' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/parks/#{park.id}/trees"

    within '#parktree_0' do
      expect(page).to have_content(tree_1.species)
    end

    within '#parktree_1' do
      expect(page).to have_content(tree_2.species)
    end

    expect(page).to have_link('Sort Alphabetically')
    click_link 'Sort Alphabetically'
    expect(page).to have_current_path("/parks/#{park.id}/trees?sort=alpha")

    within '#parktree_0' do
      expect(page).to have_content(tree_2.species)
    end

    within '#parktree_1' do
      expect(page).to have_content(tree_1.species)
    end
  end
end