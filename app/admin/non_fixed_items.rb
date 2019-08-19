# frozen_string_literal: true

# NonFixedItem 
ActiveAdmin.register NonFixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :vendor_id, :rate, :category_id
  index do
    column :id 
    column :name
    column :category
    column :quantity
    column :rate
    column 'Total amount' do |nonfixeditem|
      nonfixeditem.quantity * nonfixeditem.rate
    end
    div class: 'my-panel' do
      h3 "Total items: #{collection.pluck(:quantity).reduce(:+)}"
    end
    actions
  end
  form do |f|
    f.inputs 'Non Fixed Item' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all
      f.input :quantity
      f.input :rate
      f.input :vendor_id, label: 'Vendor', as: :select, collection: Vendor.all
      li do
        link_to 'Add new Vendor', new_admin_vendor_path
      end
      f.actions
    end
  end
  filter :name
  filter :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all
  filter :quantity
  filter :rate
  filter :vendor
end
