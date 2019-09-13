# frozen_string_literal: true

class AddWithdrawnQuantityToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :withdrawn_quantity, :integer
  end
end
