# frozen_string_literal: true

# Controller for employee dashboard
class EmployeeDashboardController < ApplicationController
  def index
    if employee_signed_in?
      @email = current_employee.email
      @item_requests = current_employee.item_request
    else
      redirect_to new_employee_session_path
    end
  end
end
