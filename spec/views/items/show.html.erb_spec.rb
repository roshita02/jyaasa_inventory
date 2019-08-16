# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'items/show', type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
                            name: 'Name',
                            type: 'Type',
                            rate: 2
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/2/)
  end
end
