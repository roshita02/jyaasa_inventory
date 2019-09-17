# frozen_string_literal: true

ActiveAdmin.register ItemAssignment do
  menu false
  config.clear_action_items!
  permit_params :employee_id, :category_id, :item_id, :quantity, :status, :returned_date
  scope :assigned, default: true
  scope :returned
  index do
    column :employee
    column :item
    column :quantity
    column 'Assigned date' do |item_assignment|
      item_assignment.created_at.to_date
    end

    column :returned_date unless params['scope'] == 'assigned'
    column('Action') do |item_assignment|
      if item_assignment.status == 'assigned'
        (link_to 'View', admin_item_assignment_path(item_assignment), class: 'btn btn-primary') + "\t\t" +
        (link_to 'Returned', returned_admin_item_assignment_path(item_assignment), method: :patch, class: 'btn btn-success', data: { confirm: 'Are you sure? ' })
      else
        (link_to 'View', admin_item_assignment_path(item_assignment), class: 'btn btn-primary')
      end
    end
  end

  form do |f|
    f.inputs  'Assign Item' do
      f.input :employee_id, label: 'Employee', as: :select, collection: Employee.all.map { |employee| [employee.email, employee.id] }, prompt: 'Select one'
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select one', input_html: { class: 'categorylist' }
      f.input :item_id, label: 'Item', as: :select, collection: FixedItem.all.map { |i| [i.name, i.id] }, prompt: 'Select one', input_html: { class: 'itemfilterlist' }
      f.input :quantity
    end
    f.actions do
      f.action :submit, label: 'Assign'
      f.cancel_link(:back)
    end
  end

  member_action :returned, method: :patch do
    item_assignment = ItemAssignment.find(params[:id])
    item_assignment.update_attribute :status, 'returned'
    item_assignment.update_attribute :returned_date, Time.now
    borrowed_qty = ItemAssignment.find_by_id(params[:id]).quantity.to_i
    @borrowed_item = ItemAssignment.find_by_id(params[:id]).item
    @borrowed_item.decrement!(:assigned_quantity, borrowed_qty)
    redirect_to admin_item_assignments_path, notice: 'Item marked as returned!'
  end

  controller do
    def create
      if params[:item_assignment][:item_id].present? && params[:item_assignment][:quantity].present?
        if Item.find_by_id(params[:item_assignment][:item_id]).quantity >= params[:item_assignment][:quantity].to_i
          @item_assignment = ItemAssignment.new(item_assignment_params)
          if @item_assignment.save
            @used_item = Item.find_by_id(params[:item_assignment][:item_id])
            @used_item.increment!(:assigned_quantity, params[:item_assignment][:quantity].to_i)
            ItemAssignmentMailer.new_assignment(@item_assignment, @used_item).deliver_now
            flash[:success] = 'Item assignment successful'
            redirect_to admin_fixed_items_path
          else
            redirect_to new_admin_item_assignment_path
          end
        else
          flash[:error] = 'The quantity you entered is not currently available'
          redirect_to new_admin_item_assignment_path
        end
      else
        super
      end
    end

    private

    def item_assignment_params
      params.require(:item_assignment).permit(:category_id, :item_id, :employee_id, :quantity, :status, :returned_date)
    end
  end

  csv do
    column :employee do |i|
      "#{i.employee.first_name} #{i.employee.last_name}"
    end
    column :item do |i|
      i.item.name.to_s
    end
    column :quantity
    column :created_at
  end

  filter :employee_id, as: :select, collection: Employee.all.map { |employee| [employee.email, employee.id] }
  filter :item_id, as: :select, collection: FixedItem.all.map { |fixeditem| [fixeditem.name, fixeditem.id] }
  filter :created_at
end
