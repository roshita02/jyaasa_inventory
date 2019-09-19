# frozen_string_literal: true

ActiveAdmin.register Employee do
  menu priority: 8
  # config.clear_action_items!
  actions :all, except: %i[new]
  permit_params :email, :first_name, :last_name, :designation, :invitation_token

  index do
    column 'Name' do |employee|
      "#{employee.first_name} #{employee.last_name}"
    end
    column :email
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
      messages = @employee.errors.full_messages.map { |msg| msg }.join(', ')
      flash[:error] = 'Error : ' + messages
      redirect_to new_invitation_admin_employees_path
    end
  end

  form do |f|
    f.inputs 'Employee details' do
      f.input :first_name
      f.input :last_name
      f.input :designation
    end
  end

  show do
    columns do
      column do
        attributes_table do
          row :first_name
          row :last_name
          row :email
          row('Invitation Sent at', &:invitation_sent_at)
          row('Invitation Accepted at', &:invitation_accepted_at)
        end
      end

      column do
        panel 'Item use statistics' do
          paginated_collection(employee.item_assignment.page(params[:page]).per(4), download_links: false) do
            table_for(collection) do
              column :item
              column :quantity
              column(:status) { |item_assignment| status_tag(item_assignment.status) }
            end
          end
        end
      end
    end
  end

  csv do
    column :first_name
    column :last_name
    column :designation
    column :email
    column :invitation_sent_at
    column :invitation_accepted_at
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :designation
  filter :invitation_sent_at
  filter :invitation_accepted_at
end
