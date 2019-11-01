# frozen_string_literal: true

# Employee_invitation
class EmployeesInvitationController < Devise::InvitationsController
  before_action :update_resource_params, only: :update
  def update
    super
  end

  def edit
    super
  end

  private

  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    # Report accepting invitation to analytics
    # Analytics.report('invite.accept', resource.id)
    resource
  end

  def update_resource_params
    params.require(resource_name).permit(
      :invitation_token,
      :password,
      :password_confirmation,
      :current_password
    )
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation) do |u|
      u.permit(:name, :email, :designation, :contact_no, :address, :password, :password_confirmation, :raw_invitation_token, :current_password)
    end
  end
end
