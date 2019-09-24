require 'rails_helper'

RSpec.describe 'FixedItemCategory', :type => :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    sign_in admin_user
    @category = FactoryBot.create(:category)
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end

  it 'created a new fixed item' do
    visit new_admin_fixed_item_category_path 
    fill_in 'fixed_item_category_name', :with => @category.name
    fill_in 'fixed_item_category_depreciation_rate', :with => @category.depreciation_rate
    click_button 'Create Fixed item category'
    expect(page).to have_text('Fixed item category was successfully created.')
  end
end
