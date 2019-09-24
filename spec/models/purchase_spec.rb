# frozen_string_literal: true

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
