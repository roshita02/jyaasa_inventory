# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FixedItem, type: :model do
  it 'should have rate' do
    item = FixedItem.new(rate: nil)
    expect(item).to_not be_valid
  end
end
