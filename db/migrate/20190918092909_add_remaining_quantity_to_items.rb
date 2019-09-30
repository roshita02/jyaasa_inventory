class AddRemainingQuantityToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :remaining_quantity, :integer
  end
end
