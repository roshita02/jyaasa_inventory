ActiveAdmin.register FixedItemPurchase do
  menu parent: 'Purchases' 
  permit_params :item_id, :vendor_id, :quantity, :rate, :purchased_date
  index do
    column :purchased_date
    column :item
    column :vendor
    column :quantity
    column :rate
    # column 'Total amount' do |purchase|
     # purchase.quantity * purchase.rate
    # end
  end
  
  form do |f|
    f.inputs 'Purchase' do
      f.input :item_id, label: 'Item', as: :select, collection: FixedItem.all, prompt: 'Select one'
      # f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select one'
      f.input :quantity
      f.input :rate
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
      @purchase = FixedItemPurchase.new(purchase_params)
      if @purchase.save
        @item = Item.find_by_id(params[:fixed_item_purchase][:item_id])
        @item.increment!(:quantity, params[:fixed_item_purchase][:quantity].to_i)
        redirect_to admin_fixed_item_purchases_path
      else
        render 'new'
      end
    end

    private

    def purchase_params
      params.require(:fixed_item_purchase).permit(:item_id, :vendor_id, :quantity, :rate, :purchased_date)
    end
  end 
end
