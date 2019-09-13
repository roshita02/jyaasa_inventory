# frozen_string_literal: true

class Withdraw < ApplicationRecord
  belongs_to :item
  validates_presence_of :quantity
end
