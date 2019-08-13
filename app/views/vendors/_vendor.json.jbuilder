# frozen_string_literal: true

json.extract! vendor, :id, :name, :pan_no, :created_at, :updated_at
json.url vendor_url(vendor, format: :json)
