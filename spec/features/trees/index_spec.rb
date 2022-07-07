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

  # User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index

  it 'has link to tree index' do
    visit "/trees"
    expect(page).to have_link('Trees Index')
    click_link 'Trees Index'
    expect(current_path).to eq("/trees")
  end

  # User Story 9, Parent Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Parent Index

  it 'has link to park index' do
    visit "/trees"
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq("/parks")
  end
end