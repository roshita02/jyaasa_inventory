# frozen_string_literal: true

class AddReturnedDateToItemReturns < ActiveRecord::Migration[6.0]
  def change
    add_column :item_returns, :returned_date, :date
  end
end
