# frozen_string_literal:true

# Activeadmin for FixedItem
ActiveAdmin.register FixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :category_id
  config.clear_action_items!
  action_item :new do
    link_to 'New Purchase', new_admin_fixed_item_purchase_path
  end
  action_item :new do
    link_to 'Purchase list', admin_fixed_item_purchases_path
  end
  action_item :new do
    link_to 'Assign Item', new_admin_item_assignment_path
  end
  index do
    column :id
    column :name
    column :category
    column 'Total Quantity', :quantity
    column 'Assigned Quantity', :assigned_quantity
    actions
    # div class: 'my-panel' do
    # h3 "Total items: #{collection.pluck(:quantity).reduce(:+)}"
    # end
  end
  form do |f|
    f.inputs 'Fixed Item' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select one'
    end
    f.actions do
      f.action :submit
      f.cancel_link(:back)
    end
  end

  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { FixedItemCategory.all.map { |i| [i.name, i.id] } }
  filter :quantity
end
