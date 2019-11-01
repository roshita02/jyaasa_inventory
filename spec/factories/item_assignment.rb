# frozen_string_literal: true

FactoryBot.define do
  factory :item_assignment do
    item { 'Tool' }
    quantity { '1' }
    employee { 'nil' }
  end
end
