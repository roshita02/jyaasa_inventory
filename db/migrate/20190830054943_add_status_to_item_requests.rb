# frozen_string_literal: true

# Migration for adding status to tem
class AddStatusToItemRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :item_requests, :status, :integer, default: 2
  end
end
