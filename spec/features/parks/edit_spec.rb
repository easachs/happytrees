# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Edit Park' do
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

  it 'can update park' do
    park = Park.create!(name: 'Turtle Park', affluent: false, year: 1950)
    visit "/parks/#{park.id}/edit"
    fill_in 'Name', with: 'Sloans Lake'
    fill_in 'Year', with: '1940'
    check 'Affluent'
    click_button 'Update Park'

    expect(current_path).to eq("/parks/#{park.id}")
    expect(page).to have_content('Sloans Lake')
    expect(page).to have_content('1940')
    expect(page).to have_content('Affluent')
  end
end
