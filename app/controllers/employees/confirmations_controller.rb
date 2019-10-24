# frozen_string_literal: true

class Employees::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  def create
    if Employee.exists?(email: params[:employee][:email])
      if Employee.find_by_email(params[:employee][:email]).sign_in_count.zero?
        super
      else
        flash[:error] = 'Email already confirmed. Sign in instead'
      end
    else
      super
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  def after_confirmation_path_for(_resource_name, resource)
    # sign_in(resource) # In case you want to sign in the user
    token = resource.send(:set_reset_password_token)
    edit_employee_password_url(resource, reset_password_token: token)
  end
end
