# frozen_string_literal: true

# Migration for creating Item returns
class CreateItemReturns < ActiveRecord::Migration[6.0]
  def change
    create_table :item_returns do |t|
      t.references :item, null: false, foreign_key: true
      t.references :item_assignment, foreign_key: true
      t.references :item_transfer, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
