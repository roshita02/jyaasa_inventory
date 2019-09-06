# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::VendorsController, type: :controller do
  render_views
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'when attributes are valid' do
      # it 'creates a new vendor' do
      # expect {
      #  post :create, params: { vendor: FactoryBot.attributes_for(:vendor) }
      # }.to change(Vendor, :count).by(1)
      # end
    end
    context 'when attributes are invalid' do
      it 'doesnot save vendor' do
        expect do
          post :create, params: { vendor: FactoryBot.attributes_for(:vendor, :invalid) }
        end.to_not change(Vendor, :count)
      end

      it 're renders new view' do
        post :create, params: { vendor: FactoryBot.attributes_for(:vendor, :invalid) }
        expect(response).to render_template :new
      end
    end
  end
end
