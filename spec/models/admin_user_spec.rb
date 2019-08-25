# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it 'should have email address' do
    admin = AdminUser.new(email: nil)
    expect(admin).to_not be_valid
  end
  it 'should have a password' do
    admin = AdminUser.new(password: nil)
    expect(admin).to_not be_valid
  end
end
