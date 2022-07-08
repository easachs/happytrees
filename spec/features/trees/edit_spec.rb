require 'rails_helper'

RSpec.describe 'Edit Tree' do

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

  it 'can update tree' do
    park = Park.create!(name: "Turtle Park", affluent: false, year: 1950)
    tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
    visit "/trees/#{tree_1.id}/edit"
    fill_in 'Species', with: 'Catalpa'
    fill_in 'Diameter', with: '30'
    click_button 'Update Tree'

    expect(current_path).to eq("/trees/#{tree_1.id}")
    expect(page).to have_content('Catalpa')
    expect(page).to have_content('30')
    expect(page).to have_content('Unhealthy')
  end
end