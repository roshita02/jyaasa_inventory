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

FactoryBot.define do
  factory :item_return do
    item_assignment { nil }
    item_transfer { nil }
    quantity { 1 }
  end
end
