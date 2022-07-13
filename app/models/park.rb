class Park < ApplicationRecord
  has_many :trees, dependent: :delete_all
  validates_presence_of :name
  validates_presence_of :year
  validates :affluent, inclusion: [true, false]

  def format_created
    created_at.strftime("%m/%d/%Y at %-l:%M%P")
  end
  
  def tree_count
    trees.count
  end

  def self.sort_by_new
    order(created_at: :desc)
  end

  def self.sort_by_treecount
    left_joins(:trees)
    .group(:id)
    .order(Arel.sql('count(trees.id) desc'))
  end

  def self.exact_search(search)
    where('name = ?', search)
  end

  def self.partial_search(search)
    where('name Like ?', "%#{search}%")
  end
end