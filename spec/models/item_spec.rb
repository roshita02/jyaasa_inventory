# frozen_string_literal: true

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
