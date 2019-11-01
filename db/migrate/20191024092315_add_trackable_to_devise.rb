# frozen_string_literal: true

class AddTrackableToDevise < ActiveRecord::Migration[6.0]
  def up
    add_column :employees, :sign_in_count, :integer, default: 0, null: false
    add_column :employees, :current_sign_in_at, :datetime
    add_column :employees, :last_sign_in_at, :datetime
    add_column :employees, :current_sign_in_ip, :inet
    add_column :employees, :last_sign_in_ip, :inet
  end

  def down
    remove_columns :employees, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
  end
end
