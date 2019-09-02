# frozen_string_literal: true

ActiveAdmin.register ItemRequest do
  scope :pending, default: true
  scope :approved
  scope :rejected
  actions :all, :except => [:new, :edit, :destroy]
  permit_params :item, :quantity, :status, :reason, :employee_id
  index do
    selectable_column
    column :employee_id do |i|
      "#{i.employee.first_name} #{i.employee.last_name}"
      # "#{self.firstname} #{self.lastname}"
    end
    column :item
    column :quantity
    # column :status 
    actions defaults: true do |item_request|
      if item_request.status == 'pending'
        (link_to 'Approve', approve_admin_item_request_path(item_request), :method => :patch) + "\t" +
        (link_to 'Reject', reject_admin_item_request_path(item_request), :method => :patch)
      end
    end
  end
  member_action :approve, method: :patch do
    item_request = ItemRequest.find(params[:id])
    item_request.update_attribute :status, 'approved'
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
      row('Requested at'){ |item_request| item_request.created_at}
      row :status
      row :reason
    end
  end
  filter :employee_id, :as => :select, :collection => Employee.all.map {|employee| [employee.email, employee.id]}
  filter :item
  filter :created_at, label: 'Requested at'
end
