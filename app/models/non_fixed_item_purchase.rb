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

# STI for non fixed item purchase
class NonFixedItemPurchase < Purchase
end
