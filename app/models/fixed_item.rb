# frozen_string_literal: true

# Model for fixed item inheriting from Item
class FixedItem < Item
  belongs_to :vendor
end
