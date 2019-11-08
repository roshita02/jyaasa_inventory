# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id                :bigint           not null, primary key
#  name              :string
#  type              :string
#  depreciation_rate :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# STI model for Fixed item category
class FixedItemCategory < Category
  validates_presence_of :depreciation_rate
  validates_numericality_of :depreciation_rate, less_than_or_equal_to: 100
end
