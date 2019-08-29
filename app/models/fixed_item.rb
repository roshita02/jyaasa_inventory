# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id             :bigint           not null, primary key
#  name           :string
#  type           :string
#  rate           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  vendor_id      :bigint
#  quantity       :integer
#  category_id    :bigint
#  purchased_date :date
#

# Model for fixed item inheriting from Item
class FixedItem < Item
  validates_presence_of :rate, :purchased_date
end
