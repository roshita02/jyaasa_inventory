# frozen_string_literal: true

json.array! @item_requests, partial: 'item_requests/item_request', as: :item_request
