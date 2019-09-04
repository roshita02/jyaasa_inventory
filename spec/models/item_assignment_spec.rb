# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemAssignment, type: :model do
  it 'is not valid without item name' do
    item = ItemAssignment.new(item: nil)
    expect(item).to_not be_valid
  end

  it 'is not valid without quantity' do
    item = ItemAssignment.new(quantity: nil)
    expect(item).to_not be_valid
  end
end
