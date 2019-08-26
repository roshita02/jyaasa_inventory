# frozen_string_literal: true

# Controller for employee dashbaord
class EmployeeDashboardController < ApplicationController
  def index
    if employee_signed_in?
      @email = current_employee.email
    else
      redirect_to new_employee_session_path
    end
  end
end