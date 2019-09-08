# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    quantity { 1 }
    rate { 1 }
    purchased_date { '2019-09-08' }
    asset { nil }
    vendor { nil }
  end
end
