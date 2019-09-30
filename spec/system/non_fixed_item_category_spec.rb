require 'rails_helper'

RSpec.describe 'NonFixedItemCategory', :type => :system do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    sign_in admin_user
    @category = FactoryBot.create(:non_fixed_item_category)
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end

  it 'creates a new fixed item' do
    visit admin_non_fixed_item_categories_path 
    click_link 'New Non Fixed Item Category'
    fill_in 'non_fixed_item_category_name', :with => @category.name
    click_button 'Create Non fixed item category'
    expect(page).to have_text('Non fixed item category was successfully created.')
  end
end
