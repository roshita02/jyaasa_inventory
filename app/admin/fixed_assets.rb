# frozen_string_literal: true

ActiveAdmin.register FixedAsset do
  menu parent: 'Assets'
  permit_params :name, :category_id
  index do
    column :name
    column :category
    column 'Total Quantity', :quantity
    actions
  end
  form do |f|
    f.inputs 'Fixed Assets' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select one'
    end
    f.actions
  end
  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { FixedItemCategory.all.map { |i| [i.name, i.id] } }
end
