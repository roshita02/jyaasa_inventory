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


require 'rails_helper'

RSpec.describe FixedItemCategory, type: :model do
  it 'should have category name' do
    category = Category.new(name: nil)
    expect(category).to_not be_valid
  end

  it 'should have depreciation rate' do
    category = Category.new(depreciation_rate: nil)
    expect(category).to_not be_valid
  end
end
