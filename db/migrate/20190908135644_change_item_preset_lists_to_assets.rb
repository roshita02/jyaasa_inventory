# frozen_string_literal:true

# Migration to change item preset list table to asset
class ChangeItemPresetListsToAssets < ActiveRecord::Migration[6.0]
  def change
    rename_table :item_preset_lists, :assets
  end
end
