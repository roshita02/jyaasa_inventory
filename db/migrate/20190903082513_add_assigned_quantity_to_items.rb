# frozen_string_literal: true

# Migration for adding assigned quantity attribute to Items
class AddAssignedQuantityToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :assigned_quantity, :integer, null: true
  end
end
