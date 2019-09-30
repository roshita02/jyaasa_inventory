# frozen_string_literal: true

# Model for item assignment
class ItemAssignment < ApplicationRecord
  belongs_to :employee
  belongs_to :category
  belongs_to :item
  validates_presence_of :quantity, :employee_id, :category_id, :item_id
  enum status: { assigned: 1, returned: 0 }
  scope :returned, -> { where(status: 'returned') }
  scope :assigned, -> { where(status: 'assigned') }
  after_save :remaining_quantity

  def remaining_quantity
    item.remaining_quantity = item.remaining_quantity - quantity
    item.save
  end
end
