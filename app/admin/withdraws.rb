# frozen_string_literal: true

ActiveAdmin.register Withdraw do
  menu false
  permit_params :category_id, :item_id, :quantity
  config.clear_action_items!

  index do
    column 'Withdrawal date' do |withdrawal|
      withdrawal.created_at.to_date
    end
    column :item
    column :quantity
  end

  form do |f|
    f.inputs 'Withdraw an Item' do
      f.input :category_id, label: 'Category', as: :select, collection: NonFixedItemCategory.all, prompt: 'Select category', input_html: { class: 'categorylist' }
      f.input :item_id, label: 'Item name', as: :select, collection: NonFixedItem.all.map { |i| [i.name, i.id] }, prompt: 'Select an item', input_html: { class: 'itemfilterlist' }
      f.input :quantity, label: 'Quantity (qty)', placeholder: 'Enter quantity'
    end
    f.actions do
      f.action :submit, label: 'Withdraw'
      f.cancel_link(:back)
    end
  end

  controller do
    def create
      if params[:withdraw][:item_id].present? && params[:withdraw][:quantity].present?
        if Item.find_by_id(params[:withdraw][:item_id]).remaining_quantity.to_i >= params[:withdraw][:quantity].to_i
          @withdraw = Withdraw.new(withdraw_params)
          if @withdraw.save
            @item = Item.find_by_id(params[:withdraw][:item_id])
            @item.increment!(:withdrawn_quantity, params[:withdraw][:quantity].to_i)
            # @item.decrement!(:quantity, params[:withdraw][:quantity].to_i)
            @item.save
            redirect_to admin_non_fixed_items_path
          else
            redirect_to new_admin_withdraw_path
          end
        else
          flash[:error] = 'The quantity you entered is not currently available'
          redirect_to new_admin_withdraw_path
        end
      else
        super
      end
    end

    private

    def withdraw_params
      params.require(:withdraw).permit(:category_id, :item_id, :quantity)
    end
  end

  filter :item_id, as: :select, collection: proc { NonFixedItem.all.map { |fixeditem| [fixeditem.name, fixeditem.id] } }
  filter :created_at, label: 'Withdrawn date'

  csv do
    column :created_at
    column :item do |i|
      i.item.name.to_s
    end
    column :quantity
  end
end
