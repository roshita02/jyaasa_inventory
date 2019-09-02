# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }
  content title: proc { I18n.t('active_admin.dashboard') } do
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
    # content
    columns do
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
        panel 'Employees' do
          h2 Employee.count
        end
      end

      column do
        panel 'Item Requests' do
          h2 ItemRequest.all.where('status': 'pending').count
        end
      end

      column do
        panel 'Vendors' do
          h2 Vendor.count
        end
      end
    end
  end
end
