# frozen_string_literal: true

ActiveAdmin.register Employee do
  menu priority: 8
  # config.clear_action_items!
  actions :all, except: %i[new]
  permit_params :email, :name, :designation, :contact_no, :address, :invitation_token

  index do
    column :id
    column :name
    column :designation
    column :email
    column :contact_no
    column :address
    column :invitation_sent_at
    column :invitation_accepted_at
    actions
  end

  action_item :new do
    link_to 'Invite New Employee', new_invitation_admin_employees_path
  end

  action_item :only => :index do
    link_to 'Import', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render 'admin/csv/upload_csv'
  end

  collection_action :import_csv, :method => :post do
    Employee.import(params[:csv])
    redirect_to :action => :index, :flash => 'File imported successfully!'
  end

  collection_action :new_invitation do
    @employee = Employee.new
  end

  collection_action :send_invitation, method: :post do
    @employee = Employee.invite!({ email: params[:employee][:email], name: params[:employee][:name],
       designation: params[:employee][:designation], contact_no: params[:employee][:contact_no], address: params[:employee][:address] },
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
      f.input :name
      f.input :designation
      f.input :email
      f.input :contact_no
      f.input :address
    end
    f.actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :first_name
          row :last_name
          row :designation
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
  filter :name
  filter :first_name
  filter :last_name
  filter :designation
  filter :invitation_sent_at
  filter :invitation_accepted_at
  
end
