# frozen_string_literal: true

# Migration for adding purchased date attribute in Items table
class AddPurchasedDateToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :purchased_date, :date
  end
end
