# frozen_string_literal: true

# == Schema Information
#
# Table name: item_transfers
#
#  id                 :bigint           not null, primary key
#  quantity           :integer
#  item_id            :bigint           not null
#  item_assignment_id :bigint           not null
#  employee_id        :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :item_transfer do
  end
end
