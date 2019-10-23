# frozen_string_literal: true

# Controller for employee session
class Employees::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in 

  def create
    if Employee.exists?(email: params[:employee][:email])
      if Employee.find_by_email(params[:employee][:email]).invitation_accepted_at.nil?
        @employee = Employee.find_by_email(params[:employee][:email])
        invitee = Employee.invite!(email: @employee.email, name: @employee.name, designation: @employee.designation, contact_no: @employee.contact_no, address: @employee.address, invitation_sent_at: Date.today) do |u|
          u.skip_invitation = true
        end
        raw_invitation_token = invitee.raw_invitation_token
        redirect_to accept_employee_invitation_url(invitation_token: raw_invitation_token)
      else
        super
      end
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(_resource)
    employee_dashboard_index_path(current_employee)
  end
end
