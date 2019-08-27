# frozen_string_literal: true

# Migration for adding employee_id to ItemRequests
class AddColumnToItemRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :item_requests, :employee_id, :integer
  end
end
