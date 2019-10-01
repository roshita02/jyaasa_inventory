# frozen_string_literal: true

# Controller for application
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :accept_invitation, keys: %i[email first_name last_name raw_invitation_token current_password name designation contact_no address]
  end
end
