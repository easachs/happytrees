require 'rails_helper'

RSpec.describe Park do
  describe 'relationships' do
    it {should have_many :trees}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :year}
    it {should allow_value(true).for(:affluent)}
    it {should allow_value(false).for(:affluent)}
  end
end