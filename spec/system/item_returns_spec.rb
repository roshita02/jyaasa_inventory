# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ItemReturn', type: :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:fixed_item_category) { FactoryBot.create(:fixed_item_category) }
  let!(:employee) { FactoryBot.create(:employee) }
  let!(:fixed_item) { FixedItem.create!(name: 'Tool', category: fixed_item_category, quantity: '5', remaining_quantity: '5') }
  let!(:item_assignment) { ItemAssignment.create!(item: fixed_item, category: fixed_item_category, quantity: '2', employee: employee) }
  # let!(:employee) { Employee.create!(name: 'Harry', designation: 'Intern', email: 'harry@gmail.com', address: 'KTM', contact_no: '1234567890')}
  before do
    sign_in admin_user
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    visit admin_item_assignments_path
  end

  it 'is able to return an item with valid attributes' do
    click_link 'Returned'
    page.driver.browser.switch_to.alert.accept
    fill_in 'item_return_quantity', with: '1'
    click_button 'Create Item return'
    expect(page).to have_text 'Item return successful'
  end

  it 'is not able to fill returned quantity with value greater than assigned quantity' do
    click_link 'Returned'
    page.driver.browser.switch_to.alert.accept
    fill_in 'item_return_quantity', with: '3'
    click_button 'Create Item return'
    expect(page).to have_text 'Return Quantity should not be greater than item assigned quantity'
  end
end
