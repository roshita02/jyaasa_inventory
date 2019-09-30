require 'rails_helper'

RSpec.describe 'Dashboard', :type => :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    sign_in admin_user
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end

  it 'redirects to dashboard' do
    visit admin_dashboard_path
    assert_selector 'h2', text: 'Dashboard'
  end
end
