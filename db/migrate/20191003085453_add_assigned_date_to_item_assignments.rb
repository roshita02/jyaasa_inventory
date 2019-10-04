# frozen_string_literal: true

# Migration for adding assigned date to Item Assignment
class AddAssignedDateToItemAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :item_assignments, :assigned_date, :date
  end
end
