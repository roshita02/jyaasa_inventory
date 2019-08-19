# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  name        :string
#  type        :string
#  rate        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  quantity    :integer
#  category_id :bigint
#  vendor_id   :bigint
#
# Model for non-fixed item inheriting from Item
class NonFixedItem < Item
end
