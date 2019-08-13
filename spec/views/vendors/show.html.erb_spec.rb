# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'vendors/show', type: :view do
  before(:each) do
    @vendor = assign(:vendor, Vendor.create!(
                                name: 'Name',
                                pan_no: 2
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
