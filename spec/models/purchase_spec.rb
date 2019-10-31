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
require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it 'is not valid without item' do
    purchase = Purchase.new(item_id: nil)
    expect(purchase).to_not be_valid
  end

  it 'is not valid without category' do
    purchase = Purchase.new(category_id: nil)
    expect(purchase).to_not be_valid
  end

  it 'is not valid without quantity' do
    purchase = Purchase.new(quantity: nil)
    expect(purchase).to_not be_valid
  end
end
