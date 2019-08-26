# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemRequestsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/item_requests').to route_to('item_requests#index')
    end

    it 'routes to #new' do
      expect(get: '/item_requests/new').to route_to('item_requests#new')
    end

    it 'routes to #show' do
      expect(get: '/item_requests/1').to route_to('item_requests#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/item_requests/1/edit').to route_to('item_requests#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/item_requests').to route_to('item_requests#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/item_requests/1').to route_to('item_requests#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/item_requests/1').to route_to('item_requests#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/item_requests/1').to route_to('item_requests#destroy', id: '1')
    end
  end
end
