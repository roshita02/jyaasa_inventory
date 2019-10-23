# frozen_string_literal: true

class AddTransferredQuantityToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :transferred_quantity, :integer
  end
end
