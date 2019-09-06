# frozen_string_literal: true

ActiveAdmin.register FixedItemPresetList do
  menu parent: 'Preset Items'
  permit_params :item_name, :category_id
  index do
    column :item_name
    column :category
    column 'Total Quantity', :quantity
    actions
  end
  form do |f|
    f.inputs 'Preset Fixed Items' do
      f.input :item_name
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select one'
    end
    f.actions
  end
  filter :item_name
  filter :category_id, label: 'Category', as: :select, collection: proc { FixedItemCategory.all.map { |i| [i.name, i.id] } }
end
