# frozen_string_literal: true

# Model for base class item
class Item < ApplicationRecord
<<<<<<< HEAD
  validates_presence_of :name, :rate
  belongs_to :vendor
=======
  validates_presence_of :name, :quantity
  belongs_to :vendor, class_name: "Vendor", foreign_key: "vendor_id", optional: true
>>>>>>> feature/item
end
