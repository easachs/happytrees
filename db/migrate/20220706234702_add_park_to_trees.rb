class AddParkToTrees < ActiveRecord::Migration[5.2]
  def change
    add_reference :trees, :park, foreign_key: true
  end
end
