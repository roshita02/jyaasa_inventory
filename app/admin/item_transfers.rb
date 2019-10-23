# frozen_string_literal: true

ActiveAdmin.register ItemTransfer do
  menu false
  permit_params :employee_id, :item_id, :item_assignment_id, :quantity
  config.clear_action_items!

  index do
    column :id
    column :item_id do |i|
      Item.find(i.item_id).name
    end
    column('Transferred from') do |i|
      Employee.find(ItemAssignment.find(i.item_assignment_id).employee_id).name
    end
    column('Transferred to') do |i|
      Employee.find(i.employee_id).name
    end
    column('Transferred Quantity', :quantity)
    column('Action') do |item_transfer|
      span link_to 'View', admin_item_transfer_path(item_transfer), class: 'btn btn-primary'
      if item_transfer.quantity > 0
        span link_to 'Returned', returned_admin_item_transfer_path(item_transfer), method: :patch, class: 'btn btn-success', data: { confirm: 'Are you sure? ' }
      end
    end
  end

  member_action :returned, method: :patch do
    @item_transfer = ItemTransfer.find(params[:id])
    session[:transfer] = @item_transfer
    redirect_to new_admin_item_return_path
  end

  form do |f|
    f.inputs  'Transfer Item' do
      f.input :employee_id, as: :select, prompt: 'Select employee', collection: Employee.all.reject { |employee| employee.id == session[:passed_variable]['employee_id'] }.map { |employee| ["#{employee.name.capitalize}, #{employee.designation.capitalize}", employee.id] }
      f.input :item_id, as: :select, include_blank: false, collection: FixedItem.all.select { |item| item.id == session[:passed_variable]['item_id'] }
      f.input :quantity, label: 'Transfer Quantity(Qty)', placeholder: 'Enter quantity', min: 1, max: session[:passed_variable]['quantity']
    end
    actions
  end

  controller do
    def create
      item_assignment_id = session[:passed_variable]['id']
      @item_assignment = ItemAssignment.find(item_assignment_id)
      if @item_assignment.quantity >= params[:item_transfer][:quantity].to_i
        @transfer = ItemTransfer.new(item_assignment_id: item_assignment_id, employee_id: params[:item_transfer][:employee_id],
                                     item_id: params[:item_transfer][:item_id], quantity: params[:item_transfer][:quantity])
        if @transfer.save
          ItemTransferNotifierMailer.new_item_transfer(@transfer, @item_assignment).deliver_now
          ItemTransferNotifierMailer.new_item_received(@transfer, @item_assignment).deliver_now
          @borrowed_item = ItemAssignment.find(item_assignment_id).item
          @borrowed_item.decrement!(:assigned_quantity, params[:item_transfer][:quantity].to_i)
          @borrowed_item.increment(:transferred_quantity, params[:item_transfer][:quantity].to_i)
          @borrowed_item.save!
          @item_assignment.decrement!(:quantity, params[:item_transfer][:quantity].to_i)
          @item_assignment.save!
          redirect_to admin_item_assignments_path
        end
      else
        flash[:error] = 'Transferred Quantity should not be greater than item assigned quantity'
        redirect_to new_admin_item_transfer_path
      end
    end

    private

    def item_transfer_params
      params.require(:item_transfer).permit(:employee_id, :item_id, :item_assignment_id, :quantity)
    end
  end

  show do
    columns do
      column max_width: '666px' do
        attributes_table do
          row :item
          row :quantity
          row('Transferred from') do |i|
            Employee.find(ItemAssignment.find(i.item_assignment_id).employee_id).name
          end
          row('Transferred to') do |i|
            Employee.find(i.employee_id).name
          end
        end
      end
    end
  end
end
