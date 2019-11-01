# frozen_string_literal: true

json.extract! item, :id, :name, :type, :rate, :created_at, :updated_at
json.url item_url(item, format: :json)
