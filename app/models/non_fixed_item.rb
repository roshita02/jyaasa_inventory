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
class NonFixedItem < Item
  after_update :update_remaining_quantity
  after_commit :update_status, on: %i[create update]

  def update_remaining_quantity
    quantity = self.quantity
    withdrawn_quantity = self.withdrawn_quantity.to_i
    update_column(:remaining_quantity, quantity.to_i - withdrawn_quantity.to_i)
  end

  def update_status
    quantity = remaining_quantity
    if quantity.to_i.zero?
      update_column(:status, 'out of stock')
    elsif quantity.to_i < 5
      update_column(:status, 'low stock')
    else
      update_column(:status, 'in stock')
    end
  end
end
