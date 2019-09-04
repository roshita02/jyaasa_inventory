# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    sequence(:email) { |n| "admin1#{n}@example.com" }
    password { 'password' }
  end
end
