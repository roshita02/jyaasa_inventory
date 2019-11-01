# frozen_string_literal: true

class AddCategoryToWithdraws < ActiveRecord::Migration[6.0]
  def change
    add_reference :withdraws, :category, foreign_key: true
  end
end
