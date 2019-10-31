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

# Model for User comments
class UserComment < ApplicationRecord
  validates_presence_of :body
  belongs_to :item_request
end
