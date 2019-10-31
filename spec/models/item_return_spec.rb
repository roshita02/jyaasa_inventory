# frozen_string_literal: true

# == Schema Information
#
# Table name: item_returns
#
#  id                 :bigint           not null, primary key
#  item_id            :bigint           not null
#  item_assignment_id :bigint
#  item_transfer_id   :bigint
#  quantity           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  returned_date      :date
#
require 'rails_helper'

RSpec.describe ItemReturn, type: :model do
  it 'should have returned quantity' do
    request = ItemReturn.new(quantity: nil)
    expect(request).to_not be_valid
  end
end
