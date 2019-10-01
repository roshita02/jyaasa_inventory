class AddFieldsToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :name, :string
    add_column :employees, :contact_no, :string
    add_column :employees, :address, :string
  end
end
