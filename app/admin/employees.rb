# frozen_string_literal: true

ActiveAdmin.register Employee do
  permit_params :email
  permit_params :first_name
  permit_params :last_name
  filter :email
  filter :first_name
  filter :last_name
  filter :invitation_sent_at
  filter :invitation_accepted_at
  index do
    column 'Name' do |employee|
      "#{employee.first_name} #{employee.last_name}"
    end
    column :email
    column :invitation_sent_at
    column :invitation_accepted_at
    actions
  end
  config.clear_action_items!
  action_item :new do
    link_to 'Invite New Employee', new_invitation_admin_employees_path
  end

  collection_action :new_invitation do
    @employee = Employee.new
  end

  collection_action :send_invitation, method: :post do
    @employee = Employee.invite!({ email: params[:employee][:email], first_name: params[:employee][:first_name], last_name: params[:employee][:last_name] },
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
  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row('Invitation Sent at') { |employee| employee.invitation_sent_at }
      row('Invitation Accepted at') { |employee| employee.invitation_accepted_at }
      row :invited_by
      row :invitation_token
    end
  end  
end
