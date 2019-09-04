# frozen_string_literal: true

ActiveAdmin.register ItemAssignment do
  permit_params :employee_id, :item_id, :quantity
  index do
    column :employee
    column :item
    column :quantity
    column 'Assigned at', :created_at
    actions
  end

  form do |f|
    f.inputs  'Assign Item' do
      f.input :employee_id, label: 'Employee', as: :select, collection: Employee.all.map { |employee| [employee.email, employee.id] }, prompt: 'Select one'
      f.input :item_id, label: 'Item', as: :select, collection: FixedItem.all, prompt: 'Select one'
      f.input :quantity
    end
    actions
  end

  controller do
    def create
      if Item.find_by_id(params[:item_assignment][:item_id]).quantity >= params[:item_assignment][:quantity].to_i
        @item_assignment = ItemAssignment.new(item_assignment_params)
        if @item_assignment.save
          @used_item = Item.find_by_id(params[:item_assignment][:item_id])
          @used_item.increment!(:assigned_quantity, params[:item_assignment][:quantity].to_i)
          redirect_to admin_item_assignments_path
        else
          render 'new'
        end
      else
        flash[:alert] = 'The quantity you entered is not currently available'
      end
    end

    private

    def item_assignment_params
      params.require(:item_assignment).permit(:item_id, :employee_id, :quantity)
    end
  end

  # filter :employee_id, as: :select, collection: Employee.all.map { |employee| [employee.email, employee.id] }
  # filter :item_id, as: :select, collection: FixedItem.all.map { |fixeditem| [fixeditem.name, fixeditem.id] }
  filter :created_at
end
