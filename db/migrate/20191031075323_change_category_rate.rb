# frozen_string_literal: true

# Migration for changing data type of depreciation rate in category
class ChangeCategoryRate < ActiveRecord::Migration[6.0]
  def up
    change_column :categories, :depreciation_rate, :decimal, precision: 5, scale: 2
  end

  def down
    change_column :categories, :depreciation_rate, :decimal, precision: 5, scale: 2
  end
end
