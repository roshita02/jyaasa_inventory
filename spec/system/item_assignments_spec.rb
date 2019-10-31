# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ItemAssignment', type: :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:fixed_item_category) { FactoryBot.create(:fixed_item_category) }
  let!(:employee) { FactoryBot.create(:employee) }
  let!(:fixed_item) { FixedItem.create!(name: 'Tool', category: fixed_item_category, quantity: '5', remaining_quantity: '5') }
  # let!(:item_assignment) { ItemAssignment.create!(item: 'Tool', category: fixed_item_category, quantity: '2')}
  before do
    sign_in admin_user
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    visit admin_fixed_items_path
  end

  it 'is able to assign an item' do
    click_link 'Assign an Item'
    select 'Roshita, Intern', from: :item_assignment_employee_id
    select 'OFFICE EQUIPMENT', from: :item_assignment_category_id
    select 'Tool', from: :item_assignment_item_id
    fill_in 'item_assignment_quantity', with: '1'
    click_button 'Assign'
    expect(page).to have_text 'Item assignment successful'
  end
end
