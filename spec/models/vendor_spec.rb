# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it 'is not valid without vendor name' do
    vendor = Vendor.new(name: nil)
    expect(vendor).to_not be_valid
  end
  it 'is not valid without pan number' do
    vendor = Vendor.new(pan_no: nil)
    expect(vendor).to_not be_valid
  end
end
