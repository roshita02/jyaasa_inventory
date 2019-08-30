# frozen_string_literal: true

# == Schema Information
#
# Table name: item_requests
#
#  id          :bigint           not null, primary key
#  item        :string
#  quantity    :integer
#  reason      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :integer
#

# Model for Item request
class ItemRequest < ApplicationRecord
  belongs_to :employee
  validates_presence_of :item, :quantity, :reason
  enum status: { approved: 1, rejected: 0, pending: 2 }
end
