class Park < ApplicationRecord
  has_many :trees
  validates_presence_of :name
  validates_presence_of :year
  validates :affluent, inclusion: [true, false]

  def tree_count
    trees.count
  end

  def self.sort_by_new
    order(created_at: :desc)
  end
end