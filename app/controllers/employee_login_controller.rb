# frozen_string_literal: true

# Controller for employee login
class EmployeeLoginController < ApplicationController
  include Wicked::Wizard
  steps :confirm_email, :confirm_password

  def index
    case step
      when :confirm_email
          @employee  = Employee.new
      when :confirm_password
    end
    render_wizard
  end
end
