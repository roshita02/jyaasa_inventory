# frozen_string_literal: true

class AddTransferredDateToItemAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :item_assignments, :transferred_date, :date
  end
end
