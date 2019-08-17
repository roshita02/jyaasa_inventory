class FixedItemCategory < Category
  validates_presence_of :depreciation_rate
  has_many :fixed_items, class_name: "FixedItem", foreign_key: "item_id" 
end
