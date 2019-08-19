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
end
