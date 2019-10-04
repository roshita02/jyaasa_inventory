# frozen_string_literal: true

class ItemRequestNotifierMailer < ApplicationMailer
  default from: 'admin@example.com'

  def new_item_request(item_request, employee)
    @item_request = item_request
    @employee = employee
    mail(to: AdminUser.pluck(:email), subject: 'New Item Request')
  end
end
