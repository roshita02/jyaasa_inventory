ActiveAdmin.register Item do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :rate
  config.remove_action_item(:new)
  action_item :new do
    link_to 'New Fixed asset', new_admin_item_path
  end
  action_item :new do
    link_to 'New Non-Fixed asset', new_admin_item_path
  end
end
