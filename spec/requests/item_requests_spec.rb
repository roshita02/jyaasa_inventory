# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ItemRequests', type: :request do
  describe 'GET /item_requests' do
    it 'works! (now write some real specs)' do
      get item_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
