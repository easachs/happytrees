require 'rails_helper'

RSpec.describe 'Tree Show' do

  # User Story 4, Child Show 

  # As a visitor
  # When I visit '/child_table_name/:id'
  # Then I see the child with that id including the child's attributes:

  it 'displays tree species' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/trees/#{tree_1.id}"

    expect(page).to have_content(tree_1.species)
    expect(page).to_not have_content(tree_2.species)
  end

  it 'displays tree attributes' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/trees/#{tree_1.id}"

    expect(page).to have_content("Diameter: #{tree_1.diameter} in")
    expect(page).to have_content("Healthy")
    expect(page).to_not have_content("Unhealthy")
  end

  # User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index

  it 'has link to tree index' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    visit "/trees/#{tree_1.id}"
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
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    visit "/trees/#{tree_1.id}"
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq("/parks")
  end

  # User Story 14, Child Update 

  # As a visitor
  # When I visit a Child Show page
  # Then I see a link to update that Child "Update Child"
  # When I click the link
  # I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
  # When I click the button to submit the form "Update Child"
  # Then a `PATCH` request is sent to '/child_table_name/:id',
  # the child's data is updated,
  # and I am redirected to the Child Show page where I see the Child's updated information

  it 'has link to update tree' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    visit "/trees/#{tree_1.id}"
    expect(page).to have_link('Update Tree')
    click_link 'Update Tree'
    expect(current_path).to eq("/trees/#{tree_1.id}/edit")
  end

  # User Story 20, Child Delete 

  # As a visitor
  # When I visit a child show page
  # Then I see a link to delete the child "Delete Child"
  # When I click the link
  # Then a 'DELETE' request is sent to '/child_table_name/:id',
  # the child is deleted,
  # and I am redirected to the child index page where I no longer see this child

  it 'has link to delete tree' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    tree = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    visit "/trees"

    expect(page).to have_content("#{tree.species}")
    expect(page).to have_content("#{tree.diameter}")

    visit "/trees/#{tree.id}"

    expect(page).to have_link('Delete Tree')

    click_link 'Delete Tree'
    expect(current_path).to eq("/trees")
    
    expect(page).to_not have_content("#{tree.species}")
    expect(page).to_not have_content("#{tree.diameter}")
  end
end