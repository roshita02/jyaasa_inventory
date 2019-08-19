# frozen_string_literal: true

ActiveAdmin.register NonFixedItemCategory do
  menu parent: 'Category'
  permit_params :name
  index do
    column :name
    actions
  end
  form do |f|
    f.inputs 'Non fixed item category' do
      f.input :name
    end
    f.actions
  end
  show do
    attributes_table do
      row :name
      row 'Items' do
        NonFixedItemCategory.find(params[:id]).items
      end
    end
  end
end
