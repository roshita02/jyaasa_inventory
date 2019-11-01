# frozen_string_literal: true

# Migration for adding quantity in Items table
class AddQuantityToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :quantity, :integer
  end
end
