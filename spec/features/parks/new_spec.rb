require 'rails_helper'

RSpec.describe 'Create Park' do
  
  # User Story 11, Parent Creation 

  # As a visitor
  # When I visit the Parent Index page
  # Then I see a link to create a new Parent record, "New Parent"
  # When I click this link
  # Then I am taken to '/parents/new' where I  see a form for a new parent record
  # When I fill out the form with a new parent's attributes:
  # And I click the button "Create Parent" to submit the form
  # Then a `POST` request is sent to the '/parents' route,
  # a new parent record is created,
  # and I am redirected to the Parent Index page where I see the new Parent displayed.

  it 'can create new park' do
    visit "/parks/new"
    fill_in 'Name', with: 'Sloans Lake'
    fill_in 'Year', with: '1940'
    check 'Affluent'
    click_button 'Create Park'

    expect(current_path).to eq("/parks")

    within '#park_0' do
      expect(page).to have_content('Sloans Lake')
      expect(page).to have_content('1940')
      expect(page).to have_content('Affluent')
    end
  end
end