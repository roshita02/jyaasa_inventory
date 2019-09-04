# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:email) { |n| "roshitashk123#{n}@gmail.com" }
    password { 'roshita123' }
  end
end
