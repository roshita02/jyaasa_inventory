# frozen_string_literal: true

# Migration for Creating vendors
class CreateVendors < ActiveRecord::Migration[6.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.integer :pan_no

      t.timestamps
    end
  end
end
