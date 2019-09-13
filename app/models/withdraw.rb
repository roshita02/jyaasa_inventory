class Withdraw < ApplicationRecord
  belongs_to :item
  validates_presence_of :quantity
end
