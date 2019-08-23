# frozen_string_literal: true

ActiveAdmin.register Employee do
  permit_params :email
  permit_params :first_name
  filter :email
  filter :first_name
  filter :invitation_sent_at
  filter :invitation_accepted_at
  index do
    column :first_name
    column :last_name
    column :email
    column :invitation_sent_at
    column :invitation_accepted_at
    actions
  end
  config.remove_action_item(:new)
  action_item :new do
    link_to 'Invite New Employee', new_invitation_admin_employees_path
  end

  collection_action :new_invitation do
    @employee = Employee.new
  end

  collection_action :send_invitation, method: :post do
    @employee = Employee.invite!({ email: params[:employee][:email] },
                                 current_employee)
    if @employee.errors.empty?
      flash[:success] = 'Employee has been successfully invited.'
      redirect_to admin_employees_path
    else
      messages = @employee.errors.full_messages.map { |msg| msg }.join
      flash[:error] = 'Error :' + messages
      redirect_to new_invitation_admin_employees_path
    end
  end
end
