# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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
