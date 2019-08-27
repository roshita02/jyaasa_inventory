# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'item_requests/new', type: :view do
  before(:each) do
    assign(:item_request, ItemRequest.new(
                            item: 'MyString',
                            quantity: 1,
                            reason: 'MyText'
                          ))
  end

  it 'renders new item_request form' do
    render

    assert_select 'form[action=?][method=?]', item_requests_path, 'post' do
      assert_select 'input[name=?]', 'item_request[item]'

      assert_select 'input[name=?]', 'item_request[quantity]'

      assert_select 'textarea[name=?]', 'item_request[reason]'
    end
  end
end
