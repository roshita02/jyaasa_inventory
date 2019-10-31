# frozen_string_literal: true

# == Schema Information
#
# Table name: transfer_requests
#
#  id          :bigint           not null, primary key
#  employee_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :transfer_request do
    employee { nil }
  end
end
