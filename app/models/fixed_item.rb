# frozen_string_literal: true

# Model for fixed item inheriting from Item
class FixedItem < Item
  has_many :vendor
end
