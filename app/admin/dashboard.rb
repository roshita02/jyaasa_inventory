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
          h1 ItemAssignment.all.where('quantity > 0').count
        end
      end

      column do
        panel 'Items transferred' do
          h1 ItemTransfer.all.where('quantity > 0').count
        end
      end

      column do
        panel 'Employees' do
          h1 Employee.count
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
              
              binding.pry
              
              t.column('Employee') do |i|
                i.employee.name.capitalize
              end
              t.column :item
              t.column 'Qty', &:quantity
              t.column('Action') do |item_request|
                span link_to 'View', admin_item_request_path(item_request), class: 'btn btn-primary'
                span link_to 'Approve', approve_admin_item_request_path(item_request), method: :patch, class: 'btn btn-success', data: { confirm: 'Are you sure? ' }
                span link_to 'Reject', reject_admin_item_request_path(item_request), method: :patch, class: 'btn btn-danger', data: { confirm: 'Are you sure? ' }
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
