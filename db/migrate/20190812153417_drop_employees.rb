class DropEmployees < ActiveRecord::Migration[6.0]
  def change
    drop_table :employees
  end
end
