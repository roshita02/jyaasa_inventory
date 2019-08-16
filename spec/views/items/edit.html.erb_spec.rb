# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'items/edit', type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
                            name: 'MyString',
                            type: '',
                            rate: 1
                          ))
  end

  it 'renders the edit item form' do
    render

    assert_select 'form[action=?][method=?]', item_path(@item), 'post' do
      assert_select 'input[name=?]', 'item[name]'

      assert_select 'input[name=?]', 'item[type]'

      assert_select 'input[name=?]', 'item[rate]'
    end
  end
end
