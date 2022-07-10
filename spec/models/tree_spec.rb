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

  describe 'class methods' do
    it 'only shows healthy trees' do
      park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
      tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
      tree_2 = park.trees.create!(species: "Elm", healthy: false, diameter: 28)
      
      expect(Tree.all.length).to eq(2)
      expect(Tree.show_healthy.length).to eq(1)
      expect(Tree.show_healthy.last.id).to eq(tree_1.id)
    end

    it 'orders trees alphabetically' do
      park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
      tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
      tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)

      expect(Tree.all.first.id).to eq(tree_1.id)
      expect(Tree.all.last.id).to eq(tree_2.id)
      expect(Tree.alphabetical.first.id).to eq(tree_2.id)
      expect(Tree.alphabetical.last.id).to eq(tree_1.id)
    end

    it 'only shows tree above certain diameter' do
      park = Park.create!(name: "Turtle Park", affluent: true, year: 1950)
      tree_1 = park.trees.create!(species: "Spruce", healthy: true, diameter: 32)
      tree_2 = park.trees.create!(species: "Elm", healthy: true, diameter: 28)

      expect(Tree.all.length).to eq(2)
      expect(Tree.diam(28).length).to eq(1)
      expect(Tree.diam(30).last.id).to eq(tree_1.id)
    end
  end
end