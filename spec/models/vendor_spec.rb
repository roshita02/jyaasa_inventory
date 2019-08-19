# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it "is not valid without name" do
    vendor = Vendor.new(name: nil)
    expect(vendor).to_not be_valid
  end
end
