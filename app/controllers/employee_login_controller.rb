# frozen_string_literal: true

# Controller for employee login
class EmployeeLoginController < ApplicationController
  include Wicked::Wizard
  steps :confirm_email, :confirm_password

  def show
    render_wizard
  end
end
