# frozen_string_literal: true

# Migration for Item
class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :type
      t.integer :rate

      t.timestamps
    end
  end
end
