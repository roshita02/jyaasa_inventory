# frozen_string_literal: true

# Migration for adding designation to employees
class AddDesignationToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :designation, :string
  end
end
