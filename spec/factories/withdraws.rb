# frozen_string_literal: true

# == Schema Information
#
# Table name: withdraws
#
#  id          :bigint           not null, primary key
#  quantity    :integer
#  item_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#


FactoryBot.define do
  factory :withdraw do
    quantity { 1 }
    item { nil }
  end
end
