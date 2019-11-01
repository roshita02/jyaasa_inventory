# frozen_string_literal: true

# Migration to change item_name to name in asset table
class ChangeItemNameToAsset < ActiveRecord::Migration[6.0]
  def change
    rename_column :assets, :item_name, :name
  end
end
