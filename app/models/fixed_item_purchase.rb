# frozen_string_literal: true

# STI for fixed item purchase
class FixedItemPurchase < Purchase
  validates_presence_of :rate, :quantity, :purchased_date
end
