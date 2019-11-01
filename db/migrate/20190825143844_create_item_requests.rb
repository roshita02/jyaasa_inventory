# frozen_string_literal: true

class CreateItemRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :item_requests do |t|
      t.string :item
      t.integer :quantity
      t.text :reason

      t.timestamps
    end
  end
end
