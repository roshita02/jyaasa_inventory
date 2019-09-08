# frozen_string_literal: true

ActiveAdmin.register NonFixedAsset do
  menu parent: 'Assets'
  permit_params :name, :category_id
  index do
    column :name
    column :category
    column 'Total Quantity', :quantity
    actions
  end
  form do |f|
    f.inputs 'Non-Fixed Assets' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all, prompt: 'Select one'
    end
    f.actions
  end
  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { NonFixedItemCategory.all.map { |i| [i.name, i.id] } }
end
