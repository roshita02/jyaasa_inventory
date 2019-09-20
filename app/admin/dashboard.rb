# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }
  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Fixed Items' do
          h1 FixedItem.count
        end
      end

      column do
        panel 'Non Fixed Items' do
          h1 NonFixedItem.count
        end
      end

      column do
        panel 'Items assigned' do
          h1 ItemAssignment.all.where('status': 'assigned').count
        end
      end

      column do
        panel 'Employees' do
          h1 Employee.count
        end
      end

      column do
        panel 'Vendors' do
          h1 Vendor.count
        end
      end
    end
  
    columns do
      column do
        panel 'Non Fixed Item Status' do
          pie_chart Item.group(:status).count, donut: true, colors: ['#e70a0a', '#4CAF50', '#f5af0f'], messages: { empty: 'No data' }
        end
      end

      column do
        panel 'Pending Item requests' do
          if ItemRequest.where(status: 'pending').count != 0
            table_for ItemRequest.where(status: 'pending').order(created_at: :desc).limit(5) do |t|
              t.column :employee_id do |i|
                "#{i.employee.first_name.capitalize} #{i.employee.last_name.capitalize}"
              end
              t.column :item
              t.column 'Qty', &:quantity
              t.column('Action') do |item_request|
                span link_to 'View', admin_item_request_path(item_request), class: 'btn btn-primary'
                span link_to 'Approve', approve_admin_item_request_path(item_request), method: :patch, class: 'btn btn-success'
                span link_to 'Reject', reject_admin_item_request_path(item_request), method: :patch, class: 'btn btn-danger'
              end
            end
            span link_to 'View all', admin_item_requests_path 
          else
            para 'No new Item requests yet'
          end
        end
      end
    end
  end
end
