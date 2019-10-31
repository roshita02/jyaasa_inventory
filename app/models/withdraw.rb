# frozen_string_literal: true

# == Schema Information
#
# Table name: withdraws
#
#  id          :bigint           not null, primary key
#  quantity    :integer
#  item_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#

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
