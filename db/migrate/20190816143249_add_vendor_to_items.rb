# frozen_string_literal: true

# Migration for adding vendor to items
class AddVendorToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :vendor, null: true, foreign_key: true
  end
end
