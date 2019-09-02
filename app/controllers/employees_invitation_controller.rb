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
    devise_parameter_sanitizer.sanitize(:accept_invitation)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation) do |u|
      u.permit(:email, :password, :password_confirmation, :raw_invitation_token, :first_name, :last_name)
    end
  end
end
