# frozen_string_literal: true

class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
  def up
    add_column :employees, :confirmation_token, :string
    add_column :employees, :confirmed_at, :datetime
    add_column :employees, :unconfirmed_email, :string
    add_column :employees, :confirmation_sent_at, :datetime
    add_index :employees, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # users as confirmed, do the following
    Employee.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_columns :employees, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :employees, :unconfirmed_email # Only if using reconfirmable
  end
end
