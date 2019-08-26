# frozen_string_literal: true

# Migration for adding category reference to items
class AddCategoryToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :category, null: true, foreign_key: true
  end
end
