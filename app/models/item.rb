# frozen_string_literal: true

# Model for base class item
class Item < ApplicationRecord
  validates_presence_of :name, :quantity
end
