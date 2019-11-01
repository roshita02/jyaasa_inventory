# frozen_string_literal: true

# == Schema Information
#
# Table name: item_returns
#
#  id                 :bigint           not null, primary key
#  item_id            :bigint           not null
#  item_assignment_id :bigint
#  item_transfer_id   :bigint
#  quantity           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  returned_date      :date
#

# Model for item return
class ItemReturn < ApplicationRecord
  belongs_to :item_assignment, required: false
  belongs_to :item_transfer, required: false
  validates_presence_of :quantity
end
