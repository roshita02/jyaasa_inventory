# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Withdraw, type: :model do
  it 'is not valid without item name' do
    item = Withdraw.new(item: nil)
    expect(item).to_not be_valid
  end

  it 'is not valid without quantity' do
    item = Withdraw.new(quantity: nil)
    expect(item).to_not be_valid
  end
end
