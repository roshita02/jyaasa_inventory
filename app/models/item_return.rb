# frozen_string_literal: true

class ItemReturn < ApplicationRecord
  belongs_to :item_assignment, required: false
  belongs_to :item_transfer, required: false
  validates_presence_of :quantity
end
