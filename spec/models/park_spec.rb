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

  describe 'class methods' do
    it 'orders parks by most recent first' do
      park_1 = Park.create!(name: "Turtle", affluent: true, year: 1950)
      park_2 = Park.create!(name: "Holbrook", affluent: true, year: 1980)
      park_3 = Park.create!(name: "Morse", affluent: false, year: 1960)
    
      expect(Park.all.first.id).to eq(park_1.id)
      expect(Park.all.last.id).to eq(park_3.id)
      expect(Park.sort_by_new.first.id).to eq(park_3.id)
      expect(Park.sort_by_new.last.id).to eq(park_1.id)
    end
  end
end