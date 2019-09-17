# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }
  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Item Requests' do
          h2 ItemRequest.all.where('status': 'pending').count
        end
      end

      column do
        panel 'Fixed Items' do
          h2 FixedItem.count
        end
      end

      column do
        panel 'Non Fixed Items' do
          h2 NonFixedItem.count
        end
      end

      column do
        panel 'Vendors' do
          h2 Vendor.count
        end
      end
    end

    columns do
      column do
        panel 'New Item Request' do
  
        end
      end
    end
  end
end
