# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ItemRequestsController, type: :controller do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:employee) { FactoryBot.create(:employee) }
  let(:item_request) { FactoryBot.create(:item_request, employee: employee) }
  render_views

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'shows all the item request' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe '#approve' do
    it 'approves item request' do
      get :index
      patch :approve, params: { id: item_request.id }
      item_request.reload
      expect(item_request.status).to eq('approved')
    end
  end

  describe '#reject' do
    it 'rejects item request' do
      get :index
      patch :reject, params: { id: item_request.id }
      item_request.reload
      expect(item_request.status).to eq('rejected')
    end
  end

  describe 'GET #show' do
    it 'shows the item request' do
      get :show, params: { id: item_request.id }
      expect(response).to render_template :show
    end
  end
end
