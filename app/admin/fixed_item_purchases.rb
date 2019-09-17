# frozen_string_literal: true

ActiveAdmin.register FixedItemPurchase do
  # menu parent: 'Purchases'
  menu false
  config.clear_action_items!
  permit_params :category_id, :item_id, :vendor_id, :quantity, :rate, :purchased_date
  index do
    column :purchased_date
    column :item
    column :vendor
    column :quantity
    column :rate
    actions
  end

  form do |f|
    f.inputs 'Purchase details' do
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select category', input_html: { class: 'categorylist' }
        li do
          ul do
            f.input :item_id, label: 'Item', as: :select, collection: FixedItem.all, prompt: 'Select an item', input_html: { class: 'itemfilterlist' }
          end
          ul do
            link_to 'Add new Item', new_admin_fixed_item_path, class: 'abutton'
          end
        end
      # f.input :category_id, as: :select, collection: FixedItemCategory.select(:id, :name),input_html: {onchange: remote_request(:post, :change_items,{category_id: "$('#fixed_item_purchase_category_id').val()"}, :item_id)
      f.input :quantity, min: '0', placeholder: 'Enter quantity'
      f.input :rate, placeholder: 'Enter rate'
      li do
        ul do
          f.input :vendor_id, label: 'Vendor', as: :select, collection: Vendor.all, prompt: 'Select vendor'
        end
        ul do
          link_to 'Add new Vendor', new_admin_vendor_path, class: 'abutton'
        end
      end
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
      row :rate
      row :vendor
      row :purchased_date
    end
  end

  controller do
    def item_list
      category = Category.find(params[:category_id])
      items = category.items.map { |i| [i.id, i.name] }
      respond_to do |format|
        format.json { render json: items, status: :ok }
      end
    end

    def create
      @purchase = FixedItemPurchase.new(purchase_params)
      if @purchase.save
        redirect_to admin_fixed_items_path
      else
        super
      end
    end

    private

    def purchase_params
      params.require(:fixed_item_purchase).permit(:category_id, :item_id, :vendor_id, :quantity, :rate, :purchased_date)
    end
  end

  filter :item_id, label: 'Item', as: :select, collection: proc { FixedItem.all.map { |i| [i.name, i.id] } }
  filter :vendor_id
  filter :purchased_date
end
