class AddApprovedDateToItemRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :item_requests, :approved_date, :date
  end
end
