class EmployeeDashboardController < ApplicationController
  def index
    @email = current_employee.email
  end
end
