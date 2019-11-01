# frozen_string_literal: true

# Migration for Item transfer
class CreateItemTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :item_transfers do |t|
      t.integer :quantity
      t.references :item, null: false, foreign_key: true
      t.references :item_assignment, null: false, foreign_key: true
      t.references :employee, foreign_key: true
      t.timestamps
    end
  end
end
