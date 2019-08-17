# frozen_string_literal: true

# Model for fixed item inheriting from Item
class FixedItem < Item
  validates_presence_of :rate 
  belongs_to :fixed_item_category, class_name: "FixedItemCategory", foreign_key: "category_id"
end