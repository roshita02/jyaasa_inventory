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
    column :id
    column :employee_id do |i|
      i.employee.name.capitalize
    end
    column :item
    column :quantity
    # column :status
    column('Action') do |item_request|
      if item_request.status == 'pending'
        span link_to 'Approve', approve_admin_item_request_path(item_request), method: :patch, class: 'btn btn-success', data: { confirm: 'Are you sure? ' }
        span link_to 'Reject', reject_admin_item_request_path(item_request), method: :patch, class: 'btn btn-danger', data: { confirm: 'Are you sure? ' }
      end
      span link_to 'Show', admin_item_request_path(item_request), class: 'btn btn-primary'
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
    columns do
      column max_width: '666px' do
        attributes_table do
          row :employee
          row :item
          row :quantity
          row('Requested at', &:created_at)
          row :status
          row :reason
        end
      end
      column do
        active_admin_form_for [:admin, UserComment.new] do |f|
          f.inputs "Comments (#{item_request.user_comment.count})" do
            unless item_request.user_comment.all.nil?
              item_request.user_comment.order(:created_at).each do |comment|
                if !comment.admin_user_id.nil?
                  div class: 'space' do
                    ad = AdminUser.find(comment.admin_user_id)
                    span link_to ad.email, admin_admin_user_path(comment.admin_user_id), class: 'alink'
                    span comment.body
                    br
                    span comment.created_at.strftime('%Y-%m-%d %H:%M'), class: 'date'
                    span link_to 'Delete', admin_user_comment_path(comment, item_request_id: comment.item_request), method: :delete, data: { confirm: 'Are you sure?' }
                  end
                else
                  div class: 'space' do
                    emp = Employee.find(comment.employee_id)
                    span link_to emp.email, admin_employee_path(comment.employee_id), class: 'alink'
                    span comment.body
                    br
                    span comment.created_at.strftime('%Y-%m-%d %H:%M'), class: 'date'
                  end
                end
              end
              f.input :body, input_html: { rows: '4', placeholder: 'Add a comment' }, label: false
              f.hidden_field :item_request_id, value: item_request.id
              f.hidden_field :admin_user_id, value: current_admin_user.id
              
            end
          end
          f.actions do
            f.submit 'Add a Comment'
          end
        end
      end
    end
  end

  controller do
    def show
      @item_request = ItemRequest.find(params[:id])
      @user_comments = @item_request.user_comment.all
    end
  end

  filter :employee_id, as: :select, collection: proc { Employee.all.map { |employee| [employee.email, employee.id] } }
  filter :item
  filter :created_at, label: 'Requested at'
end
