# frozen_string_literal: true

ActiveAdmin.register FixedItemCategory do
  menu parent: 'Category'
  permit_params :name, :depreciation_rate
  index do
    column :name
    column :depreciation_rate
    actions
  end
  form do |f|
    f.inputs 'Fixed item category' do
      f.input :name
      f.input :depreciation_rate
    end
    f.actions
  end
  show do
    attributes_table do
      row :name
      row :depreciation_rate
      # row 'Items' do
      # FixedItemCategory.find(params[:id]).items
      # end
    end
    panel 'Items' do
      table_for fixed_item_category.items do
        column :name
      end
    end
  end
end
