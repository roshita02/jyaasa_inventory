# frozen_string_literal: true

ActiveAdmin.register NonFixedItemPurchase do
  # menu parent: 'Purchases'
  menu false
  config.clear_action_items!
  permit_params :item_id, :quantity, :purchased_date, :category_id
  index do
    column :purchased_date
    column :item
    column :quantity
    actions
  end

  form do |f|
    f.inputs 'Purchase details' do
      f.input :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all, prompt: 'Select category', input_html: { class: 'categorylist' }
      li do
        ul do
          f.input :item_id, label: 'Item', as: :select, collection: NonFixedItem.all, prompt: 'Select an item', input_html: { class: 'itemfilterlist' }
        end
        ul do
          link_to 'Add new Item', new_admin_non_fixed_item_path,class: 'abutton'
        end
      end
      f.input :quantity, min: '0', placeholder: 'Enter quantity'
      f.input :purchased_date, as: :datepicker, placeholder: 'Select purchased date'
    end
    f.actions do
      f.action :submit
      f.cancel_link(:back)
    end
  end

  show do
    attributes_table do
      row :item
      row :category
      row :quantity
      row :purchased_date
    end
  end

  controller do
    def create
      @purchase = NonFixedItemPurchase.new(purchase_params)
      if @purchase.save
        redirect_to admin_non_fixed_items_path
      else
        super
      end
    end

    private

    def purchase_params
      params.require(:non_fixed_item_purchase).permit(:category_id, :item_id, :quantity, :purchased_date)
    end
  end

  filter :item_id, label: 'Item', as: :select, collection: proc { NonFixedItem.all.map { |i| [i.name, i.id] } }
  filter :purchased_date

  csv do
    column :purchased_date
    column :item do |i|
      i.item.name.to_s
    end
    column 'Qty', &:quantity
  end
end
