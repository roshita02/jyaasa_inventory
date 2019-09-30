require 'rails_helper'

RSpec.describe 'FixedItem', :type => :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:fixed_item_category) { FactoryBot.create(:fixed_item_category)}
  let!(:vendor){ FactoryBot.create(:vendor)}
  let!(:employee) { FactoryBot.create(:employee) }
  let!(:fixed_item) { FixedItem.create!(name: 'Tool', :category => fixed_item_category, quantity: '5', remaining_quantity: '5') }

  before do
    sign_in admin_user
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    visit admin_fixed_items_path 
  end

  it 'is able to create new fixed item purchase' do
    click_link 'New Purchase'
    # Creating purchase of above fixed item
    select 'OFFICE EQUIPMENT', from: :fixed_item_purchase_category_id
    select 'Tool', from: :fixed_item_purchase_item_id
    fill_in 'fixed_item_purchase_quantity', :with => '2'
    fill_in 'fixed_item_purchase_rate', :with => '2500'
    select 'vendor1', from: :fixed_item_purchase_vendor_id
    fill_in 'fixed_item_purchase_purchased_date', :with => '2019-08-08'
    expect{
      click_button 'Create Fixed item purchase'
    }.to change(Purchase, :count).by(1) 
  end

  it 'is not able to create fixed item purchase with null attributes' do
    click_link 'New Purchase'
    click_button 'Create Fixed item purchase' 
    expect(page).to have_text("can't be blank")
  end

  it 'is able to create a new vendor within the purchase form' do
    click_link 'New Purchase'
    click_link 'Add new Vendor'
    fill_in 'vendor_name', :with => 'test'
    fill_in 'vendor_pan_no', :with => '123456789'
    click_button 'Create Vendor'
    expect(page).to have_select('fixed_item_purchase_vendor_id', options: ['Select vendor', 'vendor1', 'test'])
  end

  it 'is able to create a new item assignment' do
    click_link 'Assign an Item'
    select 'roshitashakya07@gmail.com', from: :item_assignment_employee_id
    select 'OFFICE EQUIPMENT', from: :item_assignment_category_id
    select 'Tool', from: :item_assignment_item_id
    fill_in 'item_assignment_quantity', :with => '1'
    click_button 'Assign'
    expect(page).to have_text 'Item assignment successful'  
  end

  it 'is not able to create a new item assignment with quantity greater than remaining quantity' do
    click_link 'Assign an Item'
    select 'roshitashakya07@gmail.com', from: :item_assignment_employee_id
    select 'OFFICE EQUIPMENT', from: :item_assignment_category_id
    select 'Tool', from: :item_assignment_item_id
    fill_in 'item_assignment_quantity', :with => '6'
    click_button 'Assign'
    expect(page).to have_text 'The quantity you entered is not currently available'  
  end
end
