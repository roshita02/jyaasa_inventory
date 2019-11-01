# frozen_string_literal: true

json.extract! item_request, :id, :item, :quantity, :reason, :created_at, :updated_at
json.url item_request_url(item_request, format: :json)
