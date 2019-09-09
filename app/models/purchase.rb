# frozen_string_literal: true

# Model for purchase table
class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :vendor
end
