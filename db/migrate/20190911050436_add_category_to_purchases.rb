# frozen_string_literal: true

# Migration to add category references to purchase
class AddCategoryToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_reference :purchases, :category, null: false, foreign_key: true
  end
end
