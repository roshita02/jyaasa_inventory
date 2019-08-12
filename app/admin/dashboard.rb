ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
   

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
      panel "Vendors" do
        #para "Welcome"
      end
    end

    column do
      panel "Products" do
        #para "Welcome"
      end
    end
    
    column do
      panel "Employees" do
        #para "Welcome"
      end
    end

    column do
      panel "Requests" do
        #para "Welcome"
      end
    end
  end
end
end
