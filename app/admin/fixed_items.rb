# frozen_string_literal:true

ActiveAdmin.register FixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :rate, :vendor_id, :category_id
  form do |f|
    f.inputs 'Fixed Item' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all
      f.input :quantity
      f.input :rate
      f.input :vendor_id, label: 'Vendor', as: :select, collection: Vendor.all
      li do
        link_to 'Add new Vendor', new_admin_vendor_path
      end
    end
    f.actions
  end
end
