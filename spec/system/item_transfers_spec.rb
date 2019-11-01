# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ItemTransfer', type: :system do
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
    Employee.create!(name: 'Harry', designation: 'Intern', email: 'hangry@gmail.com', address: 'KTM', contact_no: '1234567890')
  end

  it 'should contain other employee name except assigned employee name' do
    click_link 'Transfer'
    expect(page).not_to have_select('item_transfer_employee_id', options: ['Roshita, Intern'])
  end

  it 'is able to transfer an item with valid attributes' do
    click_link 'Transfer'
    select 'Harry, Intern', from: :item_transfer_employee_id
    fill_in 'item_transfer_quantity', with: '1'
    click_button 'Create Item transfer'
    expect(page).to have_text 'Item transfer successful'
  end

  it 'is not able to transfer an item greater than assigned quantity' do
    click_link 'Transfer'
    select 'Harry, Intern', from: :item_transfer_employee_id
    fill_in 'item_transfer_quantity', with: '3'
    click_button 'Create Item transfer'
    expect(page).to have_text 'Transferred Quantity should not be greater than item assigned quantity'
  end
end
