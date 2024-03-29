# frozen_string_literal: true

# Migration for creating purchase
class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.integer :quantity
      t.integer :rate
      t.date :purchased_date
      t.references :item, null: false, foreign_key: true
      t.references :vendor, foreign_key: true
      t.timestamps
    end
  end
end
