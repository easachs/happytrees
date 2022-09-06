# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Park Show' do
  it 'displays park name' do
    park1 = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    visit "/parks/#{park1.id}"

    expect(page).to have_content(park1.name)
    expect(page).to_not have_content(park2.name)
  end

  it 'displays park attributes' do
    park1 = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    visit "/parks/#{park1.id}"

    expect(page).to have_content("Established: #{park1.year}")
    expect(page).to have_content('Affluent')
  end

  it 'shows tree count' do
    park1 = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    park1.trees.create(species: 'Spruce', healthy: true, diameter: 28)
    park1.trees.create(species: 'Elm', healthy: true, diameter: 22)
    park1.trees.create(species: 'Oak', healthy: false, diameter: 25)
    visit "/parks/#{park1.id}"

    expect(page).to have_content("Tree Count: #{park1.trees.count}")
    expect(page).to have_content('Tree Count: 3')
  end

  it 'has link to tree index' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}"
    expect(page).to have_link('Trees Index')
    click_link 'Trees Index'
    expect(current_path).to eq('/trees')
  end

  it 'has link to park index' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}"
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq('/parks')
  end

  it 'has link to that parks tree index' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}"
    expect(page).to have_link("#{park.name} Trees Index")
    click_link "#{park.name} Trees Index"
    expect(current_path).to eq("/parks/#{park.id}/trees")
  end

  it 'has link to update park' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}"
    expect(page).to have_link('Update Park')
    click_link 'Update Park'
    expect(current_path).to eq("/parks/#{park.id}/edit")
  end

  it 'has link to delete park' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    # can delete park with dependents/children
    park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    visit '/parks'

    expect(page).to have_content(park.name.to_s)
    expect(page).to have_content(park.year.to_s)

    visit "/parks/#{park.id}"

    expect(page).to have_link('Delete Park')

    click_link 'Delete Park'
    expect(current_path).to eq('/parks')

    expect(page).to_not have_content(park.name.to_s)
    expect(page).to_not have_content(park.year.to_s)
  end
end
