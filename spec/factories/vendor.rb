# frozen_string_literal: true

FactoryBot.define do
  factory :vendor do
    name { 'vendor1' }
    pan_no { '123456789' }
  end
  trait :invalid do
    name { nil }
    pan_no { nil }
  end
end
