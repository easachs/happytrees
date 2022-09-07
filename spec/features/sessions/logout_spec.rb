require 'rails_helper'

RSpec.describe "Logout" do
  it 'logs out' do
    user = User.create!(username: 'eli', email: 'e@mail.com', password: 'test123', password_confirmation: 'test123')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    click_on 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You have logged out.')
  end
end