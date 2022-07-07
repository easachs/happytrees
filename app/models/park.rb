class Park < ApplicationRecord
  has_many :trees
  validates_presence_of :name
  validates_presence_of :year
  validates :affluent, inclusion: [true, false]
end