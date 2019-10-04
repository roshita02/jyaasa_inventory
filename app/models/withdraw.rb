# frozen_string_literal: true

# Model for withdraw
class Withdraw < ApplicationRecord
  belongs_to :item
  belongs_to :category
  validates_presence_of :quantity, :category_id, :item_id
  after_save :remaining_quantity

  def remaining_quantity
    item.remaining_quantity = item.remaining_quantity - quantity
    item.save
  end
end
