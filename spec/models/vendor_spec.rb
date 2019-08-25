# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it 'is not valid without name' do
    vendor = Vendor.new(name: nil)
    expect(vendor).to_not be_valid
  end
  it 'is not valid without pan number' do
    vendor = Vendor.new(pan_no: nil)
    expect(vendor).to_not be_valid
  end
  # it 'should validate_length_of(:pan_no).is_equal_to(8)'
end
