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

  # User Story 15, Child Index only shows `true` Records 

  # As a visitor
  # When I visit the child index
  # Then I only see records where the boolean column is `true`

  it 'only displays healthy trees' do
    park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
    healthy_tree = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    unhealthy_tree = park.trees.create!(species: "Ash", healthy: false, diameter: 20)
    visit "/trees"

    expect(page).to have_content(healthy_tree.species)
    expect(page).to have_content("Diameter: #{healthy_tree.diameter} in")
    expect(page).to have_content("Healthy")
    expect(page).to_not have_content(unhealthy_tree.species)
    expect(page).to_not have_content("Diameter: #{unhealthy_tree.diameter} in")
    expect(page).to_not have_content("Unhealthy")
  end

  # User Story 18, Child Update From Childs Index Page 

  # As a visitor
  # When I visit the `child_table_name` index page or a parent `child_table_name` index page
  # Next to every child, I see a link to edit that child's info
  # When I click the link
  # I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 11

  it 'has links to edit trees' do
    park = Park.create!(name: "Turtle", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/trees"

    within '#tree_0' do
      expect(page).to have_content("#{tree_1.species}")
      expect(page).to have_link('Edit')
    end

    within '#tree_1' do
      expect(page).to have_content("#{tree_2.species}")
      expect(page).to have_link('Edit')
      click_link 'Edit'
      expect(current_path).to eq("/trees/#{tree_2.id}/edit")
    end
  end

  # User Story 23, Child Delete From Childs Index Page 

  # As a visitor
  # When I visit the `child_table_name` index page or a parent `child_table_name` index page
  # Next to every child, I see a link to delete that child
  # When I click the link
  # I should be taken to the `child_table_name` index page where I no longer see that child

  it 'has link to delete next to each tree' do
    park = Park.create!(name: "Turtle", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/trees"

    within '#tree_0' do
      expect(page).to have_content("#{tree_1.species}")
      expect(page).to have_link('Delete')
    end

    within '#tree_1' do
      expect(page).to have_content("#{tree_2.species}")
      expect(page).to have_link('Delete')
      click_link 'Delete'
    end

    expect(current_path).to eq("/trees")
    expect(page).to have_content("#{tree_1.species}")
    expect(page).to_not have_content("#{tree_2.species}")
  end

  it 'has links to each tree show page' do
    park = Park.create!(name: "Turtle", affluent: true, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)
    visit "/trees"

    within '#tree_0' do
      expect(page).to have_link("#{tree_1.species}")
    end

    within '#tree_1' do
      expect(page).to have_link("#{tree_2.species}")
      click_link "#{tree_2.species}"
      expect(current_path).to eq("/trees/#{tree_2.id}")
    end
  end
end