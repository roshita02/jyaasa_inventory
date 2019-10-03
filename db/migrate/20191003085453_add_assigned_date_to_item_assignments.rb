class AddAssignedDateToItemAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :item_assignments, :assigned_date, :date
  end
end
