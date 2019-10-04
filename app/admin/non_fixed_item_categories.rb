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
      f.input :name, placeholder: 'Enter category name'
    end
    f.actions
  end
  show do
    columns do
      column do
        attributes_table do
          row :name
        end
      end

      column do
        panel 'Items' do
          paginated_collection(non_fixed_item_category.items.page(params[:page]).per(5), download_links: false) do
            table_for non_fixed_item_category.items do
              column :name
              column 'Total Qty', &:quantity
              column 'Withdrawn Qty', &:withdrawn_quantity
              column 'Remaining Qty', &:remaining_quantity
              column(:status) { |item| status_tag(item.status) }
            end
          end
        end
      end
    end
  end
  filter :name
end
