# frozen_string_literal: true

# == Schema Information
#
# Table name: purchases
#
#  id             :bigint           not null, primary key
#  quantity       :integer
#  rate           :integer
#  purchased_date :date
#  item_id        :bigint           not null
#  vendor_id      :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  type           :string
#  category_id    :bigint           not null
#

# Model for purchase table
class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :vendor, optional: true
  belongs_to :category
  validates_presence_of :quantity, :category_id, :item_id, :purchased_date

  after_create :increase_quantity
  after_destroy :decrease_quantity
  before_update :get_old_quantity
  after_update :update_quantity

  def increase_quantity
    incr_quantity = quantity
    item.increment(:quantity, incr_quantity)
    item.increment(:remaining_quantity, incr_quantity)
    item.save
  end

  def decrease_quantity
    dec_quantity = quantity
    item.decrement!(:quantity, dec_quantity)
    item.decrement!(:remaining_quantity, dec_quantity)
    item.save
  end

  def get_old_quantity
    @old_quantity = quantity_was
  end

  def update_quantity
    updated_quantity = quantity
    item = self.item
    item.quantity = (item.quantity - @old_quantity) + updated_quantity
    item.remaining_quantity = (item.remaining_quantity.to_i - @old_quantity) + updated_quantity
    item.save
  end
end
