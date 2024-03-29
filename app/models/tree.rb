# frozen_string_literal: true

class Tree < ApplicationRecord
  belongs_to :park
  validates_presence_of :species
  validates_presence_of :diameter
  validates :healthy, inclusion: [true, false]

  def self.show_healthy
    where(healthy: true)
  end

  def self.alphabetical
    order(:species)
  end

  def self.diam(diameter)
    where('diameter > ?', diameter)
  end

  def self.exact_search(search)
    where('species = ?', search)
  end

  def self.partial_search(search)
    where('species Like ?', "%#{search}%")
  end
end
