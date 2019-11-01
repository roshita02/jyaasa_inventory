# frozen_string_literal: true

# Migration for Item assignment
class CreateItemAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :item_assignments do |t|
      t.integer :quantity
      t.references :employee, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
