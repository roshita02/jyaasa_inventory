# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'NonFixedItem', type: :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:non_fixed_item_category) { FactoryBot.create(:non_fixed_item_category) }
  let!(:non_fixed_item) { NonFixedItem.create!(name: 'Pen', category: non_fixed_item_category, quantity: '5', remaining_quantity: '5') }

  before do
    sign_in admin_user
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
    visit admin_non_fixed_items_path
  end

  it 'is able to create new fixed item purchase' do
    click_link 'New Purchase'
    # Creating purchase of above non fixed item
    select 'Stationaries', from: :non_fixed_item_purchase_category_id
    select 'Pen', from: :non_fixed_item_purchase_item_id
    fill_in 'non_fixed_item_purchase_quantity', with: '2'
    expect  do
      click_button 'Create Non fixed item purchase'
    end.to change(Purchase, :count).by(1)
  end

  it 'is not able to create non fixed item purchase with null attributes' do
    click_link 'New Purchase'
    click_button 'Create Non fixed item purchase'
    expect(page).to have_text("can't be blank")
  end

  it 'is able to withdraw an item' do
    click_link 'Withdraw an Item'
    select 'Stationaries', from: :withdraw_category_id
    select 'Pen', from: :withdraw_item_id
    fill_in 'withdraw_quantity', with: '1'
    click_button 'Withdraw'
    expect(page).to have_text 'Item withdraw successful'
  end

  it 'is not able to withdraw an item with quantity greater than remaining quantity' do
    click_link 'Withdraw an Item'
    select 'Stationaries', from: :withdraw_category_id
    select 'Pen', from: :withdraw_item_id
    fill_in 'withdraw_quantity', with: '7'
    click_button 'Withdraw'
    expect(page).to have_text 'The quantity you entered is not currently available'
  end
end
