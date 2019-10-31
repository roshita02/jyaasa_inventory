# frozen_string_literal: true

# == Schema Information
#
# Table name: user_comments
#
#  id              :bigint           not null, primary key
#  body            :text
#  item_request_id :bigint           not null
#  admin_user_id   :bigint
#  employee_id     :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe UserComment, type: :model do
  it 'is not valid without body' do
    comment = UserComment.new(body: nil)
    expect(comment).to_not be_valid
  end
end
