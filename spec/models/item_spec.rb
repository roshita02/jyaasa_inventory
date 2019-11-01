# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  type                 :string
#  rate                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  vendor_id            :bigint
#  quantity             :integer
#  purchased_date       :date
#  assigned_quantity    :integer
#  category_id          :bigint
#  withdrawn_quantity   :integer
#  available_quantity   :integer
#  remaining_quantity   :integer
#  status               :integer          default("out of stock")
#  transferred_quantity :integer
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'should have name' do
    item = Item.new(name: nil)
    expect(item).to_not be_valid
  end
  it 'should have category' do
    item = Item.new(category_id: nil)
    expect(item).to_not be_valid
  end
end
