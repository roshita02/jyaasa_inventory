# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id             :bigint           not null, primary key
#  name           :string
#  type           :string
#  rate           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  vendor_id      :bigint
#  quantity       :integer
#  category_id    :bigint
#  purchased_date :date
#
class NonFixedItem < Item
  after_update :update_remaining_quantity
  after_commit :update_status, :on => [:create, :update]
  def update_remaining_quantity
    quantity = self.quantity
    withdrawn_quantity = self.withdrawn_quantity.to_i
    self.update_column(:remaining_quantity,quantity - withdrawn_quantity)
  end

  def update_status
    quantity = self.remaining_quantity
    if quantity.to_i.zero?
      self.update_column(:status,'out_of_stock')
     elsif quantity.to_i < 5
      self.update_column(:status,'low_stock')
     else
      self.update_column(:status,'in_stock')
    end
  end
end
