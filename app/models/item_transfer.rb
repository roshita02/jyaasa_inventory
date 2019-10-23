# frozen_string_literal: true

# Model for item transfer
class ItemTransfer < ApplicationRecord
  belongs_to :employee
  belongs_to :item
  belongs_to :item_assignment
  validates_presence_of :quantity
  has_many :item_return, dependent: :destroy
end
