# frozen_string_literal:true

# Activeadmin for FixedItem
ActiveAdmin.register FixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :rate, :vendor_id, :category_id, :purchased_date
  index do
    column :id
    column :name
    column :category
    column 'Total Quantity', :quantity
    column 'Assigned Quantity', :assigned_quantity
    column :vendor
    column :rate
    # column :purchased_date
    column 'Total amount' do |fixeditem|
      fixeditem.quantity * fixeditem.rate
    end
    actions
    div class: 'my-panel' do
      h3 "Total items: #{collection.pluck(:quantity).reduce(:+)}"
    end
  end
  form do |f|
    f.inputs 'Fixed Item' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select one'
      f.input :quantity
      f.input :rate
      li do
        ul do
          f.input :vendor_id, label: 'Vendor', as: :select, collection: Vendor.all, prompt: 'Select one'
        end
        ul do
          link_to 'Add new Vendor', new_admin_vendor_path
        end
      end
      f.input :purchased_date, as: :datepicker
    end
    f.actions
  end
  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { FixedItemCategory.all.map { |i| [i.name, i.id] } }
  filter :quantity
  filter :rate
  filter :vendor
  filter :purchased_date
end
