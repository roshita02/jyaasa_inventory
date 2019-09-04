# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'is not valid without email' do
    employee = Employee.new(email: nil)
    expect(employee).to_not be_valid
  end
end
