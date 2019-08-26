# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'item_requests/index', type: :view do
  before(:each) do
    assign(:item_requests, [
             ItemRequest.create!(
               item: 'Item',
               quantity: 2,
               reason: 'MyText'
             ),
             ItemRequest.create!(
               item: 'Item',
               quantity: 2,
               reason: 'MyText'
             )
           ])
  end

  it 'renders a list of item_requests' do
    render
    assert_select 'tr>td', text: 'Item'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
