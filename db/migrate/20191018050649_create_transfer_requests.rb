# frozen_string_literal: true

class CreateTransferRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :transfer_requests do |t|
      t.references :employee, null: false, foreign_key: true
      t.timestamps
    end
  end
end
