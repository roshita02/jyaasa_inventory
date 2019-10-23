# frozen_string_literal: true

FactoryBot.define do
  factory :item_return do
    item_assignment { nil }
    item_transfer { nil }
    quantity { 1 }
  end
end
