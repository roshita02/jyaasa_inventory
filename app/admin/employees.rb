# frozen_string_literal: true

ActiveAdmin.register Employee do
  menu priority: 8
  # config.clear_action_items!
  actions :all, except: %i[new edit]
  permit_params :email, :first_name, :last_name, :designation, :invitation_token

  index do
    column 'Name' do |employee|
      "#{employee.first_name} #{employee.last_name}"
    end
    column :email
    column :designation
    column :invitation_sent_at
    column :invitation_accepted_at
    actions
  end

  action_item :new do
    link_to 'Invite New Employee', new_invitation_admin_employees_path
  end

  collection_action :new_invitation do
    @employee = Employee.new
  end

  collection_action :send_invitation, method: :post do
    @employee = Employee.invite!({ email: params[:employee][:email], first_name: params[:employee][:first_name], last_name: params[:employee][:last_name], designation: params[:employee][:designation] },
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
      row('Invitation Sent at', &:invitation_sent_at)
      row('Invitation Accepted at', &:invitation_accepted_at)
      row :invited_by
    end
  end
  filter :email
  filter :first_name
  filter :last_name
  filter :designation
  filter :invitation_sent_at
  filter :invitation_accepted_at
end
