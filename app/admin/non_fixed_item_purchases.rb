ActiveAdmin.register NonFixedItemPurchase do
  menu parent: 'Purchases'
  permit_params :item_id, :quantity, :purchased_date, :vendor_id
  index do
    column :purchased_date
    column :item
    column :quantity
    actions
  end

  form do |f|
    f.inputs 'Purchase' do
      f.input :item_id, label: 'Item', as: :select, collection: NonFixedItem.all, prompt: 'Select one'
      # f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select one'
      f.input :quantity
      li do
        ul do
          f.input :vendor_id, label: 'Vendor', as: :select, collection: Vendor.all, prompt: 'Select one'
        end
        ul do
          link_to 'Add new Vendor', new_admin_vendor_path
        end
      end
      f.input :purchased_date, as: :datepicker
    end
    f.actions
  end

  controller do
    def create
      @purchase = NonFixedItemPurchase.new(purchase_params)
      if @purchase.save
        @item = Item.find_by_id(params[:non_fixed_item_purchase][:item_id])
        @item.increment!(:quantity, params[:non_fixed_item_purchase][:quantity].to_i)
        redirect_to admin_non_fixed_item_purchases_path
      else
        render 'new'
      end
    end

    private

    def purchase_params
      params.require(:non_fixed_item_purchase).permit(:item_id, :quantity, :purchased_date, :vendor_id)
    end
  end
  
  filter :item_id, label: 'Item', as: :select, collection: proc { NonFixedItem.all.map { |i| [i.name, i.id] } }
  filter :purchased_date
end
