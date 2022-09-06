# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create Tree' do
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

  it 'can create new park tree' do
    park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
    visit "/parks/#{park.id}/trees/new"
    fill_in 'Species', with: 'Siberian Elm'
    fill_in 'Diameter', with: '40'
    check 'Healthy'
    click_button 'Create Tree'

    expect(current_path).to eq("/parks/#{park.id}/trees")
    expect(page).to have_content('Siberian Elm')
    expect(page).to have_content('40')
    expect(page).to have_content('Healthy')
  end
end
