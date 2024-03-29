# frozen_string_literal: true

class CreateParks < ActiveRecord::Migration[5.2]
  def change
    create_table :parks do |t|
      t.string :name
      t.boolean :affluent
      t.integer :year

      t.timestamps
    end
  end
end
