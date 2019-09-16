class AddCategoryToItemAssignments < ActiveRecord::Migration[6.0]
  def change
    add_reference :item_assignments, :category, foreign_key: true
  end
end
