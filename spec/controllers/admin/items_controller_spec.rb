# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ItemsController, type: :controller do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  render_views

  before do
    sign_in admin_user
  end

  describe 'GET #new' do
    it 'creates a new item' do
      get :new
      expect(response).to render_template :new
    end
  end
end