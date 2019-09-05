# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ItemRequestsController, type: :controller do
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
end
