# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Park Trees Index' do
  it 'displays park name' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    visit "/parks/#{park1.id}/trees"

    expect(page).to have_content(park1.name)
    expect(page).to_not have_content(park2.name)
  end

  it 'displays tree species and attributes' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit "/parks/#{park.id}/trees"

    expect(page).to have_content(tree1.species)
    expect(page).to have_content("Diameter: #{tree1.diameter} in")
    expect(page).to have_content('Healthy')
    expect(page).to have_content(tree2.species)
    expect(page).to have_content("Diameter: #{tree2.diameter} in")
    expect(page).to_not have_content('Unhealthy')
  end

  it 'has link to tree index' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}/trees"
    expect(page).to have_link('Trees Index')
    click_link 'Trees Index'
    expect(current_path).to eq('/trees')
  end

  it 'has link to park index' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}/trees"
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq('/parks')
  end

  it 'has link to create new tree' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}/trees"
    expect(page).to have_link('Create Tree')
    click_link 'Create Tree'
    expect(current_path).to eq("/parks/#{park.id}/trees/new")
  end

  it 'has link to sort trees alphabetically' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit "/parks/#{park.id}/trees"

    within '#parktree0' do
      expect(page).to have_content(tree1.species)
    end

    within '#parktree1' do
      expect(page).to have_content(tree2.species)
    end

    expect(page).to have_link('Sort Alphabetically')
    click_link 'Sort Alphabetically'
    expect(page).to have_current_path("/parks/#{park.id}/trees?sort=alpha")

    within '#parktree0' do
      expect(page).to have_content(tree2.species)
    end

    within '#parktree1' do
      expect(page).to have_content(tree1.species)
    end
  end

  it 'has links to edit trees' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit "/parks/#{park.id}/trees"

    within '#parktree0' do
      expect(page).to have_content(tree1.species.to_s)
      expect(page).to have_link('Edit')
    end

    within '#parktree1' do
      expect(page).to have_content(tree2.species.to_s)
      expect(page).to have_link('Edit')
      click_link 'Edit'
      expect(current_path).to eq("/trees/#{tree2.id}/edit")
    end
  end

  it 'has form and button to input number value' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit "/parks/#{park.id}/trees"

    fill_in 'Diam', with: '28'
    expect(page).to have_button('Only Trees > X in Diameter')
  end

  it 'can show only parks trees with diameter more than x' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit "/parks/#{park.id}/trees"
    fill_in 'Diam', with: '28'
    click_button 'Only Trees > X in Diameter'
    expect(page).to have_current_path("/parks/#{park.id}/trees?diam=28")
    expect(page).to have_content(tree1.species)
    expect(page).to_not have_content(tree2.species)
  end

  it 'has link to delete next to each tree' do
    park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit "/parks/#{park.id}/trees"

    within '#parktree0' do
      expect(page).to have_content(tree1.species.to_s)
      expect(page).to have_link('Delete')
    end

    within '#parktree1' do
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
    visit "/parks/#{park.id}/trees"

    within '#parktree0' do
      expect(page).to have_link(tree1.species.to_s)
    end

    within '#parktree1' do
      expect(page).to have_link(tree2.species.to_s)
      click_link tree2.species.to_s
      expect(current_path).to eq("/trees/#{tree2.id}")
    end
  end
end
