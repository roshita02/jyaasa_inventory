# frozen_string_literal: true

# == Schema Information
#
# Table name: item_assignments
#
#  id                   :bigint           not null, primary key
#  quantity             :integer
#  employee_id          :bigint           not null
#  item_id              :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  status               :integer          default("assigned")
#  returned_date        :date
#  category_id          :bigint
#  assigned_date        :date
#  transferred_quantity :integer
#  returned_quantity    :integer
#  transferred_date     :date
#
require 'rails_helper'

RSpec.describe ItemAssignment, type: :model do
  it 'is not valid without item name' do
    item = ItemAssignment.new(item: nil)
    expect(item).to_not be_valid
  end

  it 'is not valid without quantity' do
    item = ItemAssignment.new(quantity: nil)
    expect(item).to_not be_valid
  end
end
