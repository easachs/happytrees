require 'rails_helper'

RSpec.describe Tree do
  describe 'relationship' do
    it {should belong_to :park}
  end

  describe 'validations' do
    it {should validate_presence_of :species}
    it {should validate_presence_of :diameter}
    it {should allow_value(true).for(:healthy)}
    it {should allow_value(false).for(:healthy)}
  end
end