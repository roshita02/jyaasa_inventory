require 'rails_helper'

RSpec.describe "vendors/edit", type: :view do
  before(:each) do
    @vendor = assign(:vendor, Vendor.create!(
      :name => "MyString",
      :pan_no => 1
    ))
  end

  it "renders the edit vendor form" do
    render

    assert_select "form[action=?][method=?]", vendor_path(@vendor), "post" do

      assert_select "input[name=?]", "vendor[name]"

      assert_select "input[name=?]", "vendor[pan_no]"
    end
  end
end
