class AddReturnedDateToItemAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :item_assignments, :returned_date, :date
  end
end
