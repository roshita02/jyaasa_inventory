# frozen_string_literal: true

# == Schema Information
#
# Table name: purchases
#
#  id             :bigint           not null, primary key
#  quantity       :integer
#  rate           :integer
#  purchased_date :date
#  item_id        :bigint           not null
#  vendor_id      :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  type           :string
#  category_id    :bigint           not null
#
FactoryBot.define do
  factory :purchase do
    quantity { 1 }
    rate { 1 }
    purchased_date { '2019-09-08' }
    asset { nil }
    vendor { nil }
  end
end
