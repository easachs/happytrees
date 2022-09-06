# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Park do
  describe 'relationships' do
    it { should have_many :trees }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :year }
    it { should allow_value(true).for(:affluent) }
    it { should allow_value(false).for(:affluent) }
  end

  describe 'instance methods' do
    it 'can format created at' do
      park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
      expect(park.format_created).to eq(park.created_at.strftime('%m/%d/%Y at %-l:%M%P'))
    end

    it 'has tree count' do
      park = Park.create!(name: 'Turtle Park', affluent: true, year: 1950)
      expect(park.tree_count).to eq(0)
      tree1 = park.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
      expect(park.tree_count).to eq(1)
    end
  end

  describe 'class methods' do
    it 'orders parks by most recent first' do
      park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
      park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
      park3 = Park.create!(name: 'Morse', affluent: false, year: 1960)

      expect(Park.all.first.id).to eq(park1.id)
      expect(Park.all.last.id).to eq(park3.id)
      expect(Park.sort_by_new.first.id).to eq(park3.id)
      expect(Park.sort_by_new.last.id).to eq(park1.id)
    end

    it 'order parks by tree count (high to low)' do
      park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
      park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
      tree1 = park2.trees.create!(species: 'Spruce', healthy: true, diameter: 32)
      tree2 = park2.trees.create!(species: 'Elm', healthy: true, diameter: 28)
      park3 = Park.create!(name: 'Morse', affluent: false, year: 1960)
      tree3 = park3.trees.create!(species: 'Elm', healthy: true, diameter: 28)

      expect(Park.all.first.id).to eq(park1.id)
      expect(Park.all.last.id).to eq(park3.id)
      expect(Park.sort_by_treecount.first.id).to eq(park2.id)
      expect(Park.sort_by_treecount.last.id).to eq(park1.id)
      expect(Park.sort_by_treecount.length).to eq(3)
    end

    it 'can search by name (exact match)' do
      park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
      park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
      park3 = Park.create!(name: 'Morse', affluent: false, year: 1960)

      expect(Park.all.first.id).to eq(park1.id)
      expect(Park.all.last.id).to eq(park3.id)
      expect(Park.exact_search('Turtle').first.id).to eq(park1.id)
      expect(Park.exact_search('Turtle').length).to eq(1)
    end

    it 'can search by name (partial match)' do
      park1 = Park.create!(name: 'Turtle', affluent: true, year: 1950)
      park2 = Park.create!(name: 'Holbrook', affluent: true, year: 1980)
      park3 = Park.create!(name: 'Moore', affluent: false, year: 1960)

      expect(Park.partial_search('oo').length).to eq(2)
      expect(Park.partial_search('oo').first.id).to eq(park2.id)
      expect(Park.partial_search('oo').last.id).to eq(park3.id)
    end
  end
end
