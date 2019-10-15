# frozen_string_literal: true

# Model for User comments
class UserComment < ApplicationRecord
  validates_presence_of :body
  belongs_to :item_request
end
