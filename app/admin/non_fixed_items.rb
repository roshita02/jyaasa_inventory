# frozen_string_literal: true

# NonFixedItem
ActiveAdmin.register NonFixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :vendor_id, :rate, :category_id, :purchased_date
  index do
    column :id
    column :name
    column :category
    column :quantity
    column :rate
    # column 'Total amount' do |nonfixeditem|
    # nonfixeditem.quantity * nonfixeditem.rate
    # end
    div class: 'my-panel' do
      h3 "Total items: #{collection.pluck(:quantity).reduce(:+)}"
    end
    actions
  end
  form do |f|
    f.inputs 'Non Fixed Item' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all, prompt: 'Select one'
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
      f.actions
    end
  end
  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { NonFixedItemCategory.all.map { |i| [i.name, i.id] } }
  filter :quantity
  filter :rate
  filter :vendor
  filter :purchased_date
end
