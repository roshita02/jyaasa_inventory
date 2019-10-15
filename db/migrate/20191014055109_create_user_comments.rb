# frozen_string_literal: true

class CreateUserComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_comments do |t|
      t.text :body
      t.references :item_request, null: false, foreign_key: true
      t.references :admin_user, foreign_key: true
      t.references :employee, foreign_key: true
      t.timestamps
    end
  end
end
