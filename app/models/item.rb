# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id             :bigint           not null, primary key
#  name           :string
#  type           :string
#  rate           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  vendor_id      :bigint
#  quantity       :integer
#  category_id    :bigint
#  purchased_date :date
#
class Item < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false}
  # belongs_to :vendor, optional: true
  belongs_to :category
  has_many :item_assignment
  has_many :purchase
end
