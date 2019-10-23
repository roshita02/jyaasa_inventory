# frozen_string_literal: true

ActiveAdmin.register ItemReturn do
  menu false
  permit_params :item_id, :item_assignment_id, :item_transfer_id, :quantity
  config.clear_action_items!
  index do
    column :id
    column('Item name') do |i|
      Item.find(i.item_id).name
    end
    column :quantity
  end

  form do |f|
    if session[:transfer].nil?
      f.inputs  'Return Item' do
        f.input :item_id, as: :select, include_blank: false, collection: FixedItem.all.select { |item| item.id == session[:assigned]['item_id'] }
        f.input :quantity, label: 'Return Quantity(Qty)', placeholder: 'Enter quantity', min: 1, max: session[:assigned]['quantity']
      end
    else
      f.inputs  'Return Item' do
        f.input :item_id, as: :select, include_blank: false, collection: FixedItem.all.select { |item| item.id == session[:transfer]['item_id'] }
        f.input :quantity, label: 'Return Quantity(Qty)', placeholder: 'Enter quantity', min: 1, max: session[:transfer]['quantity']
      end
    end
    actions
  end

  controller do
    def create
      if session[:transfer].nil?
        item_assignment_id = session[:assigned]['id'].to_i
      else
        item_transfer_id = session[:transfer]['id'].to_i
      end
      binding.pry
      if item_transfer_id.nil?
        @item_assignment = ItemAssignment.find_by_id(item_assignment_id)
        if @item_assignment.quantity >= params[:item_return][:quantity].to_i
          @return = ItemReturn.new(item_assignment_id: item_assignment_id, item_id: params[:item_return][:item_id], quantity: params[:item_return][:quantity])
          if @return.save!
            @borrowed_item = ItemAssignment.find(item_assignment_id).item
            @borrowed_item.decrement!(:assigned_quantity, params[:item_return][:quantity].to_i)
            @borrowed_item.increment(:remaining_quantity, params[:item_return][:quantity].to_i)
            @borrowed_item.save!
            @item_assignment.decrement!(:quantity, params[:item_return][:quantity].to_i)
            @item_assignment.save!
            redirect_to admin_item_assignments_path
          end
        else
          flash[:error] = 'Return Quantity should not be greater than item assigned quantity'
          redirect_to new_admin_item_return_path
        end
      else
        @item_transfer = ItemTransfer.find(item_transfer_id)
        if @item_transfer.quantity >= params[:item_return][:quantity].to_i
          @return = ItemReturn.new(item_transfer_id: item_transfer_id, item_id: params[:item_return][:item_id], quantity: params[:item_return][:quantity])
          if @return.save!
            @transferred_item = ItemTransfer.find(item_transfer_id).item
            @transferred_item.decrement!(:transferred_quantity, params[:item_return][:quantity].to_i)
            @transferred_item.increment(:remaining_quantity, params[:item_return][:quantity].to_i)
            @transferred_item.save!
            @item_transfer.decrement!(:quantity, params[:item_return][:quantity].to_i)
            @item_transfer.save!
            redirect_to admin_item_transfers_path
          end
        else
          flash[:error] = 'Return Quantity should not be greater than item transferred quantity'
          redirect_to new_admin_item_return_path
        end
        session.delete(:transfer)
      end
    end

    private

    def item_return_params
      params.require(:item_return).permit(:item_id, :item_assignment_id, :item_transfer_id, :quantity)
    end
  end

  show do
    columns do
      column max_width: '666px' do
        attributes_table do
          row :quantity
        end
      end
    end
  end
end
