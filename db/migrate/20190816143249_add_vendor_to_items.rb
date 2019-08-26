# frozen_string_literal: true

class AddVendorToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :vendor, null: true, foreign_key: true
  end
end
