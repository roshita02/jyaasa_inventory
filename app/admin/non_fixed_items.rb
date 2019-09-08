# frozen_string_literal: true

# NonFixedItem
ActiveAdmin.register NonFixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :category_id
  index do
    column :id
    column :name
    column :category
    column 'Total Quantity', :quantity
    column 'Withdrawn Quantity'
    column 'Available Quantity'
    # div class: 'my-panel' do
      # h3 "Total items: #{collection.pluck(:quantity).reduce(:+)}"
    # end
    actions
  end
  form do |f|
    f.inputs 'Non Fixed Item' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all, prompt: 'Select one'
      f.actions
    end
  end
  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { NonFixedItemCategory.all.map { |i| [i.name, i.id] } }
  filter :quantity
end
