# frozen_string_literal: true

ActiveAdmin.register ItemAssignment do
  menu false
  config.clear_action_items!
  permit_params :employee_id, :category_id, :item_id, :quantity, :status, :assigned_date, :returned_date
  scope :assigned, default: true
  scope :returned
  scope :transferred

  action_item only: :index do
    link_to 'Import file', action: 'import_item_assignment'
  end

  collection_action :import_item_assignment do
    render 'admin/csv/upload_item_assignment'
  end

  collection_action :import_file, method: :post do
    ItemAssignment.import(params[:file])
    redirect_to action: :index, notice: 'Imported sucessfully!'
  end

  index do
    column :employee_id do |i|
      i.employee.name.capitalize
    end
    column 'Designation', :employee_id do |i|
      i.employee.designation.capitalize
    end
    column :item
    column :quantity
    column :assigned_date
    column :returned_date unless params['scope'] == 'assigned'
    column('Action') do |item_assignment|
      span link_to 'View', admin_item_assignment_path(item_assignment), class: 'btn btn-primary'
      if item_assignment.status == 'assigned'
        span link_to 'Returned', returned_admin_item_assignment_path(item_assignment), method: :get, class: 'btn btn-success', data: { confirm: 'Are you sure? ' }
        span link_to 'Transfer', transfer_admin_item_assignment_path(item_assignment), method: :patch, class: 'btn btn-danger'
      end
    end
  end

  show do
    columns do
      column max_width: '662px' do
        attributes_table do
          row :employee
          row :item
          row :quantity
          row :status
          row :assigned_date
          row :returned_date
        end
      end
    end
  end

  form do |f|
    f.inputs  'Assign Item' do
      f.input :employee_id, label: 'Employee', as: :select, collection: Employee.all.map { |employee| ["#{employee.name.capitalize}, #{employee.designation.capitalize}", employee.id] }, prompt: 'Select employee'
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select category', input_html: { class: 'categorylist' }
      f.input :item_id, label: 'Item', as: :select, collection: FixedItem.all.map { |i| [i.name, i.id] }, prompt: 'Select an item', input_html: { class: 'itemfilterlist' }
      f.input :quantity, label: 'Quantity(Qty)', placeholder: 'Enter quantity'
      f.input :assigned_date, label: 'Assigned Date', as: :datepicker, placeholder: 'Select item assigned date'
    end
    f.actions do
      f.action :submit, label: 'Assign'
      f.cancel_link(:back)
    end
  end

  member_action :returned, method: :get do
    @item_assignment = ItemAssignment.find(params[:id])
    render 'admin/item_assignments/return'
    # item_assignment.update_attribute :status, 'returned'
    # item_assignment.update_attribute :returned_date, Time.now
    # borrowed_qty = ItemAssignment.find_by_id(params[:id]).quantity.to_i
    # @borrowed_item = ItemAssignment.find_by_id(params[:id]).item
    # @borrowed_item.decrement!(:assigned_quantity, borrowed_qty)
    # @borrowed_item.increment(:remaining_quantity, borrowed_qty)
    # @borrowed_item.save
  end

  member_action :return_item, method: :patch do
    @item_assignment = ItemAssignment.find(params[:id])
    # @item_assignment.update_attribute :status, 'returned'
    # @item_assignment.update_attribute :returned_date, Time.now
    @borrowed_item = ItemAssignment.find_by_id(params[:id]).item
    @borrowed_item.decrement!(:assigned_quantity, params[:item_assignment][:returned_quantity].to_i)
    @borrowed_item.increment(:remaining_quantity, params[:item_assignment][:returned_quantity].to_i)
    @borrowed_item.save!
    @item_assignment.update_attribute :status, 'returned'
    @item_assignment.update_attribute :returned_date, Time.now
  end

  member_action :transfer, method: :patch do
    @item_assignment = ItemAssignment.find(params[:id])
    # render 'admin/item_assignments/transfer'
    # @borrowed_item = ItemAssignment.find_by_id(params[:id]).item
    # @borrowed_item.decrement!(:assigned_quantity, params[:item_assignment][:returned_quantity].to_i)
    # @borrowed_item.increment(:transferred_quantity, params[:item_assignment][:returned_quantity].to_i)
    # @borrowed_item.save!
    # @item_assignment.update_attribute :status, 'transferred'
    # @item_assignment.update_attribute :transferred_date, Time.now
  end

  controller do
    def create
      if params[:item_assignment][:item_id].present? && params[:item_assignment][:quantity].present?
        if Item.find_by_id(params[:item_assignment][:item_id]).remaining_quantity.to_i >= params[:item_assignment][:quantity].to_i
          @item_assignment = ItemAssignment.new(item_assignment_params)
          if @item_assignment.save
            @item = Item.find_by_id(params[:item_assignment][:item_id])
            @item.increment!(:assigned_quantity, params[:item_assignment][:quantity].to_i)
            @item.save
            ItemAssignmentMailer.new_assignment(@item_assignment, @item).deliver_now
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
      params.require(:item_assignment).permit(:category_id, :item_id, :employee_id, :quantity, :status, :assigned_date, :returned_date)
    end
  end

  filter :employee_id, as: :select, collection: proc { Employee.all.map { |employee| [employee.email, employee.id] } }
  filter :item_id, as: :select, collection: proc { FixedItem.all.map { |fixeditem| [fixeditem.name, fixeditem.id] } }
  filter :assigned_date, label: 'Assigned at'
  filter :returned_date, label: 'Returned at'

  csv do
    column :employee do |i|
      i.employee.name
    end
    column :item do |i|
      i.item.name
    end
    column :quantity
    column :assigned_date
  end
end
