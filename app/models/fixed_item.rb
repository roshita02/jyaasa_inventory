# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  type                 :string
#  rate                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  vendor_id            :bigint
#  quantity             :integer
#  purchased_date       :date
#  assigned_quantity    :integer
#  category_id          :bigint
#  withdrawn_quantity   :integer
#  available_quantity   :integer
#  remaining_quantity   :integer
#  status               :integer          default("out of stock")
#  transferred_quantity :integer
#

# Model for fixed item inheriting from Item
class FixedItem < Item
  after_update :update_remaining_quantity
  def update_remaining_quantity
    quantity = self.quantity
    assigned_quantity = self.assigned_quantity.to_i
    update_column(:remaining_quantity, quantity - assigned_quantity - transferred_quantity.to_i)
  end
end
