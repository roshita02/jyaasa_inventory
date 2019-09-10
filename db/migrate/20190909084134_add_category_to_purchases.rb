# frozen_string_literal: true

# Migration for adding category reference to purchases table
class AddCategoryToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_reference :purchases, :category, foreign_key: true
  end
end
