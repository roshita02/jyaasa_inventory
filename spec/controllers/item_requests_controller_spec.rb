# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemRequestsController, type: :controller do
  let(:employee) { FactoryBot.create(:employee) }

  describe 'POST #create' do
    it 'creates item requests' do
      sign_in employee
      expect do
        post :create,
             params: { item_request: FactoryBot.attributes_for(:item_request) }
      end.to change(ItemRequest, :count).by(1)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      sign_in employee
      expect(response).to have_http_status(:success)
    end
  end
end
