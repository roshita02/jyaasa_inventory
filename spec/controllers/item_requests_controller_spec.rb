# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemRequestsController, type: :controller do
  let(:employee) { FactoryBot.create(:employee) }
  before(:each) do
    sign_in employee
  end

  describe 'POST #create' do
    it 'creates item requests' do 
      expect {
        post :create,
        params: { item_request: FactoryBot.attributes_for(:item_request) } 
      }.to change(ItemRequest, :count).by(1)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
