# frozen_string_literal: true

ActiveAdmin.register Withdraw do
  menu false
  permit_params :item_id, :quantity
  config.clear_action_items!

  index do
    column :item
    column :quantity
    column 'Withdraw date', :created_at
  end

  form do |f|
    f.inputs 'Withdraw an Item' do
      f.input :item_id, label: 'Item', as: :select, collection: NonFixedItem.all.map { |i| [i.name, i.id] }, prompt: 'Select one'
      f.input :quantity
    end
    f.actions do
      f.action :submit
      f.cancel_link(:back)
    end
  end

  controller do
    def create
      if params[:withdraw][:item_id].present? && params[:withdraw][:quantity].present?
        if Item.find_by_id(params[:withdraw][:item_id]).quantity >= params[:withdraw][:quantity].to_i
          @withdraw = Withdraw.new(withdraw_params)
          if @withdraw.save
            @item = Item.find_by_id(params[:withdraw][:item_id])
            @item.increment!(:withdrawn_quantity, params[:withdraw][:quantity].to_i)
            @item.decrement!(:quantity, params[:withdraw][:quantity].to_i)
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
      params.require(:withdraw).permit(:item_id, :quantity)
    end
  end
end
