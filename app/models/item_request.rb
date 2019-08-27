# frozen_string_literal: true

# Model for Item request
class ItemRequest < ApplicationRecord
  belongs_to :employee
end
