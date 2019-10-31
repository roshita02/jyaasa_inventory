# frozen_string_literal: true

# == Schema Information
#
# Table name: transfer_requests
#
#  id          :bigint           not null, primary key
#  employee_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class TransferRequest < ApplicationRecord
  belongs_to :employee
end
