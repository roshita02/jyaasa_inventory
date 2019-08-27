# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'item_requests/edit', type: :view do
  before(:each) do
    @item_request = assign(:item_request, ItemRequest.create!(
                                            item: 'MyString',
                                            quantity: 1,
                                            reason: 'MyText'
                                          ))
  end

  it 'renders the edit item_request form' do
    render

    assert_select 'form[action=?][method=?]', item_request_path(@item_request), 'post' do
      assert_select 'input[name=?]', 'item_request[item]'

      assert_select 'input[name=?]', 'item_request[quantity]'

      assert_select 'textarea[name=?]', 'item_request[reason]'
    end
  end
end
