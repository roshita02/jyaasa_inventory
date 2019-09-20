# frozen_string_literal: true

class ItemAssignmentMailer < ActionMailer::Base
  default from: 'admin@example.com'

  def new_assignment(item_assignment, item)
    @item_assignment = item_assignment
    @used_item = item
    @employee = Employee.find(item_assignment.employee_id)
    mail(to: @employee.email, subject: 'New Item assignment')
  end
end
