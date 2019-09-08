# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :vendor
end
