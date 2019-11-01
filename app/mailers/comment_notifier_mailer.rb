# frozen_string_literal: true

class CommentNotifierMailer < ApplicationMailer
  default from: 'admin@example.com'

  def new_comment(comment, item_request)
    @comment = comment
    @item_request = item_request
    if comment.employee_id.nil?
      @commentor = AdminUser.find(comment.admin_user_id)
      @employee = Employee.find(item_request.employee_id)
      mail(to: @employee.email, subject: 'New Comment')
    else
      @commentor = Employee.find(comment.employee_id)
      mail(to: AdminUser.pluck(:email), subject: 'New Comment')
    end
  end
end
