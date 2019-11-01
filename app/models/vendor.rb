# frozen_string_literal: true

# == Schema Information
#
# Table name: vendors
#
#  id         :bigint           not null, primary key
#  name       :string
#  pan_no     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null

# Model for vendor
class Vendor < ApplicationRecord
  validates_presence_of :name, :pan_no
  validates_length_of :pan_no, is: 9
  # has_many :items
  has_many :purchase
end
