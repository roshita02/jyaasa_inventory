# frozen_string_literal: true

FactoryBot.define do 
  factory :item_request do
    item { 'Mouse' }
    quantity { '2' }
    reason { 'For official use' }
  end
end
