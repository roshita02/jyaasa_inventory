# frozen_string_literal:true

# Activeadmin for FixedItem
ActiveAdmin.register FixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :category_id
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
    f.actions
  end
  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { FixedItemCategory.all.map { |i| [i.name, i.id] } }
  filter :quantity
end
