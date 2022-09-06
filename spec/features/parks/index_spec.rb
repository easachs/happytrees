# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Park Index' do
  it 'displays park name' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    visit '/parks'

    expect(page).to have_content(park1.name)
    expect(page).to have_content(park2.name)
  end

  it 'orders parks by most recent first' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    park3 = Park.create!(name: 'Morse', affluent: false, year: 1960)
    visit '/parks'

    within '#park0' do
      expect(page).to have_content(park3.name)
    end

    within '#park2' do
      expect(page).to have_content(park1.name)
    end
  end

  it 'shows when created' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    visit '/parks'

    expect(page).to have_content("Created: #{park1.format_created}")
    expect(page).to have_content("Created: #{park2.format_created}")
  end

  it 'has link to tree index' do
    visit '/parks'
    expect(page).to have_link('Trees Index')
    click_link 'Trees Index'
    expect(current_path).to eq('/trees')
  end

  it 'has link to park index' do
    visit '/parks'
    expect(page).to have_link('Parks Index')
    click_link 'Parks Index'
    expect(current_path).to eq('/parks')
  end

  it 'has link to create new park' do
    visit '/parks'
    expect(page).to have_link('New Park')
    click_link 'New Park'
    expect(current_path).to eq('/parks/new')
  end

  it 'has links to edit parks' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    visit '/parks'

    within '#park0' do
      # most recent first
      expect(page).to have_content(park2.name.to_s)
      expect(page).to have_link('Edit')
    end

    within '#park1' do
      expect(page).to have_content(park1.name.to_s)
      expect(page).to have_link('Edit')
      click_link 'Edit'
      expect(current_path).to eq("/parks/#{park1.id}/edit")
    end
  end

  it 'has link to delete next to each park' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    # can delete park with dependents/children
    park2.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    visit '/parks'

    within '#park0' do
      # most recent first
      expect(page).to have_content(park2.name.to_s)
      expect(page).to have_link('Delete')
    end

    within '#park1' do
      expect(page).to have_content(park1.name.to_s)
      expect(page).to have_link('Delete')
      click_link 'Delete'
    end

    expect(current_path).to eq('/parks')
    expect(page).to have_content(park2.name.to_s)
    expect(page).to_not have_content(park1.name.to_s)
  end

  it 'can sort parks by tree count' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    park2.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
    park2.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    park3 = Park.create!(name: 'Morse', affluent: false, year: 1960)
    park3.trees.create!(species: 'Elm', healthy: true, diameter: 28)
    visit '/parks'

    # most recent first
    within '#park0' do
      expect(page).to have_content(park3.name)
    end

    within '#park2' do
      expect(page).to have_content(park1.name)
    end

    expect(page).to have_link('Sort By Tree Count')
    click_link 'Sort By Tree Count'
    expect(page).to have_current_path('/parks?sort=treecount')

    within '#park0' do
      expect(page).to have_content(park2.name)
    end

    within '#park1' do
      expect(page).to have_content(park3.name)
    end

    within '#park2' do
      expect(page).to have_content(park1.name)
    end
  end

  it 'has links to each park show page' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    visit '/parks'

    within '#park0' do
      # most recent first
      expect(page).to have_link(park2.name.to_s)
    end

    within '#park1' do
      expect(page).to have_link(park1.name.to_s)
      click_link park1.name.to_s
      expect(current_path).to eq("/parks/#{park1.id}")
    end
  end

  it 'has search textbox and can search by exact name' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    park3 = Park.create!(name: 'Morse', affluent: false, year: 1960)
    visit '/parks'

    fill_in 'Exact search', with: 'Turtle'
    expect(page).to have_button('Exact Search')
    click_button 'Exact Search'

    expect(page).to have_current_path('/parks?exact_search=Turtle')
    expect(page).to have_content(park1.name)
    expect(page).to_not have_content(park2.name)
    expect(page).to_not have_content(park3.name)
  end

  it 'has search textbox and can search by partial name' do
    park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
    park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
    park3 = Park.create!(name: 'Moore', affluent: false, year: 1960)
    visit '/parks'

    fill_in 'Partial search', with: 'oo'
    expect(page).to have_button('Partial Search')
    click_button 'Partial Search'

    expect(page).to have_current_path('/parks?partial_search=oo')
    expect(page).to have_content(park2.name)
    expect(page).to have_content(park3.name)
    expect(page).to_not have_content(park1.name)
  end
end
