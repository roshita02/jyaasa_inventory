# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id                :bigint           not null, primary key
#  name              :string
#  type              :string
#  depreciation_rate :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null

# Model for Category
class Category < ApplicationRecord
  validates_presence_of :name
  has_many :items, foreign_key: 'category_id', dependent: :destroy
  has_many :purchase, dependent: :destroy
  has_many :item_assignment, dependent: :destroy
  has_many :withdraw, dependent: :destroy
end
