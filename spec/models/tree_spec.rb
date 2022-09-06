# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tree do
  describe 'relationship' do
    it { should belong_to :park }
  end

  describe 'validations' do
    it { should validate_presence_of :species }
    it { should validate_presence_of :diameter }
    it { should allow_value(true).for(:healthy) }
    it { should allow_value(false).for(:healthy) }
  end

  describe 'class methods' do
    it 'only shows healthy trees' do
      park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
      tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
      tree2 = park.trees.create!(species: 'Elm', healthy: false, diameter: 28)

      expect(Tree.all.length).to eq(2)
      expect(Tree.show_healthy.length).to eq(1)
      expect(Tree.show_healthy.last.id).to eq(tree1.id)
    end

    it 'orders trees alphabetically' do
      park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
      tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
      tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)

      expect(Tree.all.first.id).to eq(tree1.id)
      expect(Tree.all.last.id).to eq(tree2.id)
      expect(Tree.alphabetical.first.id).to eq(tree2.id)
      expect(Tree.alphabetical.last.id).to eq(tree1.id)
    end

    it 'only shows tree above certain diameter' do
      park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
      tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
      tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)

      expect(Tree.all.length).to eq(2)
      expect(Tree.diam(28).length).to eq(1)
      expect(Tree.diam(30).last.id).to eq(tree1.id)
    end

    it 'can search by name (exact match)' do
      park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
      tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
      tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
      tree3 = park.trees.create!(species: 'Spruce', healthy: false, diameter: 22)

      expect(Tree.exact_search('Spruce').length).to eq(2)
      expect(Tree.exact_search('Elm').length).to eq(1)
      expect(Tree.exact_search('Elm').first.id).to eq(tree2.id)
    end

    it 'can search by name (partial match)' do
      park = Park.create!(name: 'Turtle', affluent: true, year: 1950)
      tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
      tree2 = park.trees.create!(species: 'Elm', healthy: true, diameter: 28)
      tree3 = park.trees.create!(species: 'Spruce', healthy: false, diameter: 22)

      expect(Tree.partial_search('pru').length).to eq(2)
      expect(Tree.partial_search('pru').first.id).to eq(tree1.id)
      expect(Tree.partial_search('pru').last.id).to eq(tree3.id)
    end
  end
end
