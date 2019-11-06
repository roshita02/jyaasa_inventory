# frozen_string_literal: true

ActiveAdmin.register Employee do
  menu priority: 8
  # config.clear_action_items!
  scope :invited
  scope :not_invited
  scope :accepted, default: true
  actions :all, except: %i[new]
  permit_params :email, :name, :designation, :contact_no, :address, :invitation_token
  index do
    column :id
    column :name
    column :designation
    column :email
    column :invitation_sent_at if params['scope'] == 'invited'
    column :invitation_accepted_at if params['scope'] == 'accepted'
    column('Action') do |employee|
      if params['scope'] == 'not_invited' 
        span link_to 'Invite', invite_admin_employee_path(employee), method: :post, class: 'btn btn-success'
        span link_to 'Edit', edit_admin_employee_path(employee), method: :get, class: 'btn btn-warning'
      end
      if params['scope'] == 'invited' 
        span link_to 'Reinvite', invite_admin_employee_path(employee), method: :post, class: 'btn btn-success'
        span link_to 'Edit', edit_admin_employee_path(employee), method: :get, class: 'btn btn-warning'
      end
      span link_to 'View', admin_employee_path(employee), class: 'btn btn-primary'
      span link_to 'Delete', admin_employee_path(employee), method: :delete, class: 'btn btn-danger'
    end
  end

  member_action :invite, method: :post do
    @employee = Employee.find(params[:id])
    @employee.deliver_invitation
    redirect_to admin_employees_path
  end

  action_item only: :index do
    link_to 'Import file', action: 'upload_csv'
  end

  action_item :new do
    link_to 'Invite New Employee', new_invitation_admin_employees_path
  end

  collection_action :upload_csv do
    render 'admin/csv/upload_file'
  end

  collection_action :import_csv, method: :post do
    Employee.import(params[:csv])
    redirect_to action: :index, notice: 'File imported and invitation sent successfully!'
  end

  collection_action :new_invitation do
    @employee = Employee.new
  end

  collection_action :send_invitation, method: :post do
    @employee = Employee.invite!({ email: params[:employee][:email], name: params[:employee][:name],
                                   designation: params[:employee][:designation], contact_no: params[:employee][:contact_no],
                                   address: params[:employee][:address] }, current_employee)
    if @employee.errors.empty?
      flash[:success] = 'Employee has been successfully invited.'
      redirect_to admin_employees_path
    else
      # messages = @employee.errors.full_messages.map { |msg| msg }.join(', ')
      # flash[:error] = messages
      # redirect_to new_invitation_admin_employees_path
      render 'new_invitation'
    end
  end
  form do |f|
    f.inputs 'Employee details' do
      f.input :name
      f.input :designation
      f.input :email
      f.input :contact_no
      f.input :address
    end
    f.actions
  end

  controller do 
    def update
      @employee = Employee.find(params[:id])
      @employee.skip_reconfirmation!
      super
    end
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :designation
          row :email
          row :contact_no
          row :address
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
    column :name
    column :designation
    column :email
    column :contact_no
    column :address
  end

  filter :email
  filter :name
  filter :designation
  filter :contact_no
  filter :address
  filter :invitation_sent_at
  filter :invitation_accepted_at
end
