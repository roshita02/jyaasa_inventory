# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'items/index', type: :view do
  before(:each) do
    assign(:items, [
             Item.create!(
               name: 'Name',
               type: 'Type',
               rate: 2
             ),
             Item.create!(
               name: 'Name',
               type: 'Type',
               rate: 2
             )
           ])
  end

  it 'renders a list of items' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Type'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
