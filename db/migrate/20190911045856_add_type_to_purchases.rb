# frozen_string_literal: true

# Migration for adding type in purchase
class AddTypeToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_column :purchases, :type, :string
  end
end
