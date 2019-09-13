# frozen_string_literal: true

class CreateWithdraws < ActiveRecord::Migration[6.0]
  def change
    create_table :withdraws do |t|
      t.integer :quantity
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
