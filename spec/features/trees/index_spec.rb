# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tree Index' do
  it 'displays tree species' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit '/trees'

    expect(page).to have_content(tree1.species)
    expect(page).to have_content("Diameter: #{tree1.diameter} in")
    expect(page).to have_content('Healthy')
    expect(page).to have_content(tree2.species)
    expect(page).to have_content("Diameter: #{tree2.diameter} in")
    expect(page).to_not have_content('Unhealthy')
  end

  it 'has link to tree index' do
    visit '/trees'
    expect(page).to have_link('Trees Index')
    click_link 'Trees Index'
    expect(current_path).to eq('/trees')
  end

  it 'has link to park index' do
    visit '/trees'
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq('/parks')
  end

  it 'only displays healthy trees' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    healthy_tree = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    unhealthy_tree = park.trees.create!(species: 'Ash', healthy: false, diameter: 20)
    visit '/trees'

    expect(page).to have_content(healthy_tree.species)
    expect(page).to have_content("Diameter: #{healthy_tree.diameter} in")
    expect(page).to have_content('Healthy')
    expect(page).to_not have_content(unhealthy_tree.species)
    expect(page).to_not have_content("Diameter: #{unhealthy_tree.diameter} in")
    expect(page).to_not have_content('Unhealthy')
  end

  it 'has links to edit trees' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit '/trees'

    within '#tree0' do
      expect(page).to have_content(tree1.species.to_s)
      expect(page).to have_link('Edit')
    end

    within '#tree1' do
      expect(page).to have_content(tree2.species.to_s)
      expect(page).to have_link('Edit')
      click_link 'Edit'
      expect(current_path).to eq("/trees/#{tree2.id}/edit")
    end
  end

  it 'has link to delete next to each tree' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit '/trees'

    within '#tree0' do
      expect(page).to have_content(tree1.species.to_s)
      expect(page).to have_link('Delete')
    end

    within '#tree1' do
      expect(page).to have_content(tree2.species.to_s)
      expect(page).to have_link('Delete')
      click_link 'Delete'
    end

    expect(current_path).to eq('/trees')
    expect(page).to have_content(tree1.species.to_s)
    expect(page).to_not have_content(tree2.species.to_s)
  end

  it 'has links to each tree show page' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit '/trees'

    within '#tree0' do
      expect(page).to have_link(tree1.species.to_s)
    end

    within '#tree1' do
      expect(page).to have_link(tree2.species.to_s)
      click_link tree2.species.to_s
      expect(current_path).to eq("/trees/#{tree2.id}")
    end
  end

  it 'has search textbox and can search by exact name' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    tree3 = park.trees.create!(species: 'Spruce', healthy: false, diameter: 22)
    visit '/trees'

    fill_in 'Exact search', with: 'Spruce'
    expect(page).to have_button('Exact Search')
    click_button 'Exact Search'

    expect(page).to have_current_path('/trees?exact_search=Spruce')
    expect(page).to have_content(tree1.species)
    expect(page).to_not have_content(tree2.species)
    expect(page).to have_content(tree1.diameter)
    expect(page).to have_content(tree3.diameter)
  end

  it 'has search textbox and can search by partial name' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    tree3 = park.trees.create!(species: 'Spruce', healthy: false, diameter: 22)
    visit '/trees'

    fill_in 'Partial search', with: 'pru'
    expect(page).to have_button('Partial Search')
    click_button 'Partial Search'

    expect(page).to have_current_path('/trees?partial_search=pru')
    expect(page).to have_content(tree1.species)
    expect(page).to_not have_content(tree2.species)
    expect(page).to have_content(tree1.diameter)
    expect(page).to have_content(tree3.diameter)
  end
end
