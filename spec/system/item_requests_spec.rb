# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ItemRequest', type: :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:employee) { FactoryBot.create(:employee) }
  let!(:item_request) { FactoryBot.create(:item_request, employee: employee) }
  let!(:user_comment) { FactoryBot.create(:user_comment, employee_id: employee.id, item_request_id: item_request.id) }

  before do
    sign_in admin_user
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    visit admin_item_requests_path
  end

  it 'admin is able to accept item requests' do
    click_link 'Approve'
    page.driver.browser.switch_to.alert.accept
    page.evaluate_script 'window.location.reload()'
    expect(item_request.reload.status).to eq('approved')
  end

  it 'admin is able to reject item requests' do
    click_link 'Reject'
    page.driver.browser.switch_to.alert.accept
    page.evaluate_script 'window.location.reload()'
    expect(item_request.reload.status).to eq('rejected')
  end

  it 'admin is able to make comments' do
    click_link 'Show'
    fill_in 'user_comment_body', with: 'Test comment'
    click_button 'Comment'
    expect(page).to have_text 'Comment successfully added'
  end

  it 'admin is able to view comments made by employee' do
    click_link 'Show'
    expect(page).to have_text 'Employee comment'
  end
end
