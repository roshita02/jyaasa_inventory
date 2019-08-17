# frozen_string_literal: true

# Model for non-fixed item inheriting from Item
class NonFixedItem < Item
  belongs_to :vendor
end
