# frozen_string_literal: true

# Migration for adding transferred quantity to item assignment
class AddTransferredQuantityToItemAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :item_assignments, :transferred_quantity, :integer
  end
end
