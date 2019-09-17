# frozen_string_literal: true

class AddStatusToItemAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :item_assignments, :status, :integer, default: 1
  end
end
