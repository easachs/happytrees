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

  # User Story 8, Child Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Child Index

  it 'has link to tree index' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    visit "/parks/#{park.id}"
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
    visit "/parks/#{park.id}"
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq("/parks")
  end

  # User Story 10, Parent Child Index Link

  # As a visitor
  # When I visit a parent show page ('/parents/:id')
  # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')

  it 'has link to that parks tree index' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    visit "/parks/#{park.id}"
    expect(page).to have_link("#{park.name} Trees Index")
    click_link "#{park.name} Trees Index"
    expect(current_path).to eq("/parks/#{park.id}/trees")
  end

  # User Story 12, Parent Update 

  # As a visitor
  # When I visit a parent show page
  # Then I see a link to update the parent "Update Parent"
  # When I click the link "Update Parent"
  # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
  # When I fill out the form with updated information
  # And I click the button to submit the form
  # Then a `PATCH` request is sent to '/parents/:id',
  # the parent's info is updated,
  # and I am redirected to the Parent's Show page where I see the parent's updated info

  it 'has link to update park' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    visit "/parks/#{park.id}"
    expect(page).to have_link('Update Park')
    click_link 'Update Park'
    expect(current_path).to eq("/parks/#{park.id}/edit")
  end

  # User Story 19, Parent Delete 

  # As a visitor
  # When I visit a parent show page
  # Then I see a link to delete the parent
  # When I click the link "Delete Parent"
  # Then a 'DELETE' request is sent to '/parents/:id',
  # the parent is deleted, and all child records are deleted
  # and I am redirected to the parent index page where I no longer see this parent

  it 'has link to delete park' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    # can delete park with dependents/children
    tree = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    visit "/parks"

    expect(page).to have_content("#{park.name}")
    expect(page).to have_content("#{park.year}")

    visit "/parks/#{park.id}"

    expect(page).to have_link('Delete Park')

    click_link 'Delete Park'
    expect(current_path).to eq("/parks")
    
    expect(page).to_not have_content("#{park.name}")
    expect(page).to_not have_content("#{park.year}")
  end
end