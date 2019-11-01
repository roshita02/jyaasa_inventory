# frozen_string_literal: true

class RemoveFieldsFromEmployees < ActiveRecord::Migration[6.0]
  def change
    remove_column :employees, :first_name, :string

    remove_column :employees, :last_name, :string
  end
end
