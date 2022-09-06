# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create Park' do
  it 'can create new park' do
    visit '/parks/new'
    fill_in 'Name', with: 'Sloans Lake'
    fill_in 'Year', with: '1940'
    check 'Affluent'
    click_button 'Create Park'

    expect(current_path).to eq('/parks')

    within '#park0' do
      expect(page).to have_content('Sloans Lake')
      expect(page).to have_content('1940')
      expect(page).to have_content('Affluent')
    end
  end
end
