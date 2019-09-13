# frozen_string_literal: true

# NonFixedItem
ActiveAdmin.register NonFixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :category_id
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
    column :id
    column :name
    column :category
    column 'Withdrawn Quantity', :withdrawn_quantity
    column 'Available Quantity', :quantity
    # div class: 'my-panel' do
    # h3 "Total items: #{collection.pluck(:quantity).reduce(:+)}"
    # end
    # div class: 'my-panel' do
    # h3 "Total items: #{collection.pluck(:quantity).reduce(:+)}"
    # end
    actions
  end
  form do |f|
    f.inputs 'Non Fixed Item' do
      f.input :name
      f.input :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all, prompt: 'Select one'
      f.actions do
        f.action :submit
        f.cancel_link(:back)
      end
    end
  end

  controller do
    def new
      super
      @first_value = request.referer
      session[:passed_variable] = @first_value
    end

    def create
      @item = NonFixedItem.new(item_params)
      @first_value = session[:passed_variable]
      if @item.save
        flash[:success] = 'Successfully created new fixed item'
        redirect_to(@first_value)
      else
        redirect_to new_admin_non_fixed_item_path
      end
    end
  end
  
  show do
    attributes_table do
      row :name
      row :category
      row :quantity
    end
  end

  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { NonFixedItemCategory.all.map { |i| [i.name, i.id] } }
  filter :quantity
end
