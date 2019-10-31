# frozen_string_literal: true

# == Schema Information
#
# Table name: item_requests
#
#  id            :bigint           not null, primary key
#  item          :string
#  quantity      :integer
#  reason        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  employee_id   :integer
#  status        :integer          default("pending")
#  approved_date :date
#
require 'rails_helper'

RSpec.describe ItemRequest, type: :model do
  it 'should have item name' do
    request = ItemRequest.new(item: nil)
    expect(request).to_not be_valid
  end

  it 'should have quantity' do
    request = ItemRequest.new(quantity: nil)
    expect(request).to_not be_valid
  end

  it 'should have reason' do
    request = ItemRequest.new(reason: nil)
    expect(request).to_not be_valid
  end
end
