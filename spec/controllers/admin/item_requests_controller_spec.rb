# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ItemRequestsController, type: :controller do
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns http success' do 
      expect(response).to have_http_status(:success)
    end
  end
end
