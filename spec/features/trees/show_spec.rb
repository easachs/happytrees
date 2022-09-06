# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tree Show' do
  it 'displays tree species' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit "/trees/#{tree1.id}"

    expect(page).to have_content(tree1.species)
    expect(page).to_not have_content(tree2.species)
  end

  it 'displays tree attributes' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit "/trees/#{tree1.id}"

    expect(page).to have_content("Diameter: #{tree1.diameter} in")
    expect(page).to have_content('Healthy')
    expect(page).to_not have_content('Unhealthy')
  end

  it 'has link to tree index' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    visit "/trees/#{tree1.id}"
    expect(page).to have_link('Trees Index')
    click_link 'Trees Index'
    expect(current_path).to eq('/trees')
  end

  it 'has link to park index' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    visit "/trees/#{tree1.id}"
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq('/parks')
  end

  it 'has link to update tree' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    visit "/trees/#{tree1.id}"
    expect(page).to have_link('Update Tree')
    click_link 'Update Tree'
    expect(current_path).to eq("/trees/#{tree1.id}/edit")
  end

  it 'has link to delete tree' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    tree = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    visit '/trees'

    expect(page).to have_content(tree.species.to_s)
    expect(page).to have_content(tree.diameter.to_s)

    visit "/trees/#{tree.id}"

    expect(page).to have_link('Delete Tree')

    click_link 'Delete Tree'
    expect(current_path).to eq('/trees')

    expect(page).to_not have_content(tree.species.to_s)
    expect(page).to_not have_content(tree.diameter.to_s)
  end
end
