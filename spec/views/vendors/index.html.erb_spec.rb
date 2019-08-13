# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'vendors/index', type: :view do
  before(:each) do
    assign(:vendors, [
             Vendor.create!(
               name: 'Name',
               pan_no: 2
             ),
             Vendor.create!(
               name: 'Name',
               pan_no: 2
             )
           ])
  end

  it 'renders a list of vendors' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
