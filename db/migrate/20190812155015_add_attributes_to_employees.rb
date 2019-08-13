# frozen_string_literal: true

class AddAttributesToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :first_name, :string
    add_column :employees, :last_name, :string
  end
end
