# frozen_string_literal: true

# Controller for employee dashboard
class EmployeeDashboardController < ApplicationController
  helper ApplicationHelper
  def index
    if employee_signed_in?
      @item_requests = current_employee.item_request
    else
      redirect_to new_employee_session_path
    end
  end
end
