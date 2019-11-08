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
      f.input :name, placeholder: 'Enter category name'
      f.input :depreciation_rate, placeholder: 'Enter depreciation rate'
    end
    f.actions
  end
  show do
    columns do
      column do
        attributes_table do
          row :name
          row :depreciation_rate
          # row 'Items' do
          # FixedItemCategory.find(params[:id]).items
          # end
        end
      end

      column do
        panel 'Items' do
          paginated_collection(fixed_item_category.items.page(params[:page]).per(5), download_links: false) do
            table_for fixed_item_category.items do
              column :name
              column 'Total Qty', &:quantity
              column 'Assigned Qty', &:assigned_quantity
              column 'Remaining Qty', &:remaining_quantity
            end
          end
        end
      end
    end
  end
  controller do
    def update
      @category = Category.find(params[:id])
      super do
        redirect_to admin_fixed_item_categories_path, flash: { notice: 'Category updated succcessfully' } and return if resource.valid?
      end
    end
  end
  filter :name, label: 'Category name'
  filter :depreciation_rate
end
