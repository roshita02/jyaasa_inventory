# frozen_string_literal: true

# Mailer for notifying item transfer
class ItemTransferNotifierMailer < ApplicationMailer
  default from: 'admin@example.com'

  def new_item_transfer(item_transfer, item_assignment)
    @item = Item.find(item_transfer.item_id).name
    @item_transfer = item_transfer
    @old_employee = Employee.find(item_assignment.employee_id)
    @new_employee = Employee.find(item_transfer.employee_id)
    mail(to: @old_employee.email, subject: 'Item Transferred')
  end

  def new_item_received(item_transfer, item_assignment)
    @item = Item.find(item_transfer.item_id).name
    @item_transfer = item_transfer
    @old_employee = Employee.find(item_assignment.employee_id)
    @new_employee = Employee.find(item_transfer.employee_id)
    mail(to: @new_employee.email, subject: 'New Item Transferred')
  end
end
