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
# Inherited from Category
class NonFixedItemCategory < Category
  
end
