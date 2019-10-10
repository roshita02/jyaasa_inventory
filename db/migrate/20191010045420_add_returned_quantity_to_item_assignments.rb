class AddReturnedQuantityToItemAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :item_assignments, :returned_quantity, :integer
  end
end
