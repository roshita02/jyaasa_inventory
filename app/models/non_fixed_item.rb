# frozen_string_literal: true

# Model for non-fixed item inheriting from Item
class NonFixedItem < Item
  belongs_to :non_fixed_item_category, class_name: "NonFixedItemCategory", foreign_key: "category_id"
end
