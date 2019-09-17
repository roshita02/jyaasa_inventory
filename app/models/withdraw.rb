# frozen_string_literal: true

class Withdraw < ApplicationRecord
  belongs_to :item
  belongs_to :category
  validates_presence_of :quantity
end
