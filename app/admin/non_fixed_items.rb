# frozen_string_literal: true

# NonFixedItem
ActiveAdmin.register NonFixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :category_id, :status, :remaining_quantity
  config.clear_action_items!
  action_item :new do
    link_to 'New Purchase', new_admin_non_fixed_item_purchase_path
  end
  action_item :new do
    link_to 'Purchase list', admin_non_fixed_item_purchases_path
  end
  action_item :withdraw do
    link_to 'Withdraw an Item', new_admin_withdraw_path
  end
  index do
    column :name
    column :category
    column 'Total Quantity', :quantity
    column 'Withdrawn Quantity', :withdrawn_quantity
    column 'Remaining Quantity', :remaining_quantity 
    column(:status) { |item| status_tag(item.status) }
    actions
  end

  form do |f|
    f.inputs 'Item details' do
      f.input :name, placeholder: 'Enter item name'
      f.input :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all, prompt: 'Select category'
      f.input :quantity, label: 'Quantity (qty)'
    end
    f.actions do
      f.action :submit
      f.cancel_link(:back)
    end
  end

  controller do
    def new
      super
      @first_value = request.referer
      session[:passed_variable] = @first_value
    end

    def create
      params[:non_fixed_item][:remaining_quantity] = params[:non_fixed_item][:quantity]
      @item = NonFixedItem.new(item_params)
      @first_value = session[:passed_variable]
      if @item.save
        flash[:success] = 'Successfully created new fixed item'
        redirect_to(@first_value)
      else
        super
      end
    end
    
    private

    def item_params
      params.require(:non_fixed_item).permit(:name, :category_id, :status, :quantity, :remaining_quantity)
    end
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :category
          row('Qty', &:quantity)
          row :status
        end
      end

      column do
        panel 'Purchase history' do
          paginated_collection(non_fixed_item.purchase.page(params[:page]).per(5), download_links: false) do
            table_for collection do
              column :purchased_date
              column 'Qty', :quantity
            end
          end
        end
      end
    end
  end

  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { NonFixedItemCategory.all.map { |i| [i.name, i.id] } }
  filter :quantity

  csv do
    column :name
    column :category do |i|
      i.category.name.to_s
    end
    column 'Total Quantity', &:quantity
    column 'Withdrawn Quantity', &:withdrawn_quantity
    column 'Remaining Quantity', &:remaining_quantity
  end
end
