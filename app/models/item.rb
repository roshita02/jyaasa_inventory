# frozen_string_literal: true

# Model for base class item
class Item < ApplicationRecord
  validates_presence_of :name, :quantity
  belongs_to :vendor, class_name: "Vendor", foreign_key: "vendor_id", optional: true
end
