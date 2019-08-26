# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'item_requests/show', type: :view do
  before(:each) do
    @item_request = assign(:item_request, ItemRequest.create!(
                                            item: 'Item',
                                            quantity: 2,
                                            reason: 'MyText'
                                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Item/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
