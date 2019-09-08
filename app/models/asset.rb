# frozen_string_literal: true

# Model for asset
class Asset < ApplicationRecord
  validates_presence_of :name
  belongs_to :category
  validates :name, uniqueness: { case_sensitive: false }
  has_many :purchase
end
