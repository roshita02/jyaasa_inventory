# frozen_string_literal: true

# Model for fixed item inheriting from Item
class FixedItem < Item
  validates_presence_of :rate 
  belongs_to :vendor, class_name: "Vendor", foreign_key: "vendor_id"
end