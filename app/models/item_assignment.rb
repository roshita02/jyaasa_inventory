# frozen_string_literal: true

# Model for item assignment
class ItemAssignment < ApplicationRecord
  belongs_to :employee
  belongs_to :item
  validates_presence_of :quantity
  enum status: { assigned: 1, returned: 0 }
  scope :returned, -> { where(status: 'returned') }
  scope :assigned, -> { where(status: 'assigned') }
end
