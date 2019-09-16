# frozen_string_literal: true

ActiveAdmin.register ItemRequest do
  menu priority: 3
  scope :pending, default: true
  scope :approved
  scope :rejected

  actions :all, except: %i[new edit destroy]
  permit_params :item, :quantity, :status, :reason, :employee_id

  index do
    column :employee_id do |i|
      "#{i.employee.first_name.capitalize} #{i.employee.last_name.capitalize}"
      # "#{self.firstname} #{self.lastname}"
    end
    column :item
    column :quantity
    # column :status
    column('Action') do |item_request|
      if item_request.status == 'pending'
        (link_to 'Approve', approve_admin_item_request_path(item_request), method: :patch, class: 'btn btn-success') + "\t\t" +
          (link_to 'Reject', reject_admin_item_request_path(item_request), method: :patch, class: 'btn btn-danger') + "\t\t" +
          (link_to 'View', admin_item_request_path(item_request), class: 'btn btn-primary')
      else
        (link_to 'View', admin_item_request_path(item_request), class: 'btn btn-primary')
      end
    end
  end

  member_action :approve, method: :patch do
    item_request = ItemRequest.find(params[:id])
    item_request.update_attribute :status, 'approved'
    item_request.update_attribute :approved_date, Time.now
    redirect_to admin_item_requests_path, notice: 'Approved!'
  end

  member_action :reject, method: :patch do
    item_request = ItemRequest.find(params[:id])
    item_request.update_attribute :status, 'rejected'
    redirect_to admin_item_requests_path, notice: 'Rejected!'
  end

  show do
    attributes_table do
      row :employee
      row :item
      row :quantity
      row('Requested at', &:created_at)
      row :status
      row :reason
    end
  end

  filter :employee_id, as: :select, collection: Employee.all.map { |employee| [employee.email, employee.id] }
  filter :item
  filter :created_at, label: 'Requested at'
end
