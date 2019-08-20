# frozen_string_literal: true

# Employee_invitation
class EmployeesInvitationController < Devise::InvitationsController
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
end
