# frozen_string_literal: true

# Model for base class item
class Item < ApplicationRecord
  belongs_to :vendor, class_name: "vendor", foreign_key: "vendor_id"
  validates_presence_of :name, :quantity
end
