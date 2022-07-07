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

  describe 'instance methods' do
    it 'has tree count' do
      park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
      expect(park.tree_count).to eq(0)
      tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
      expect(park.tree_count).to eq(1)
    end
  end
end