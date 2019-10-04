# frozen_string_literal: true

ActiveAdmin.register ItemRequest do
  menu priority: 3
  scope :pending, default: true
  scope :approved
  scope :rejected

  actions :all, except: %i[new edit destroy]
  permit_params :item, :quantity, :status, :reason, :employee_id

  action_item :new do
    link_to 'Assign an Item', new_admin_item_assignment_path
  end

  action_item :withdraw do
    link_to 'Withdraw an Item', new_admin_withdraw_path
  end

  index do
    column :employee_id do |i|
      i.employee.name.capitalize.to_s
    end
    column :item
    column :quantity
    # column :status
    column('Action') do |item_request|
      if item_request.status == 'pending'
        span link_to 'Approve', approve_admin_item_request_path(item_request), method: :patch, class: 'btn btn-success', data: { confirm: 'Are you sure? ' }
        span link_to 'Reject', reject_admin_item_request_path(item_request), method: :patch, class: 'btn btn-danger', data: { confirm: 'Are you sure? ' }
      end
      span link_to 'View', admin_item_request_path(item_request), class: 'btn btn-primary'
    end
  end

  member_action :approve, method: :patch do
    item_request = ItemRequest.find(params[:id])
    item_request.update_attribute :status, 'approved'
    item_request.update_attribute :approved_date, Time.now
    flash[:message] = 'Item request approved'
    if request.referer.present?
      redirect_to request.referrer
    else
      redirect_to admin_item_requests_path
    end
  end

  member_action :reject, method: :patch do
    item_request = ItemRequest.find(params[:id])
    item_request.update_attribute :status, 'rejected'
    if request.referer.present?
      redirect_to request.referrer
    else
      redirect_to admin_item_requests_path
    end
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

  filter :employee_id, as: :select, collection: proc { Employee.all.map { |employee| [employee.email, employee.id] } }
  filter :item
  filter :created_at, label: 'Requested at'
end
