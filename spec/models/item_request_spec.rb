# frozen_string_literal: true

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
