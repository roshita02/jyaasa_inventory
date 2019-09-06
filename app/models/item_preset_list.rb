# frozen_string_literal: true

# Model for preset list of item
class ItemPresetList < ApplicationRecord
  validates_presence_of :item_name
  belongs_to :category
end