# frozen_string_literal: true

class CreateItemPresetLists < ActiveRecord::Migration[6.0]
  def change
    create_table :item_preset_lists do |t|
      t.string :item_name
      t.string :type
      t.integer :quantity
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
