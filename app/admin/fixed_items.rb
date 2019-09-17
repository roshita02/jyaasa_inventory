# frozen_string_literal:true

# Activeadmin for FixedItem
ActiveAdmin.register FixedItem do
  menu parent: 'Items'
  permit_params :name, :quantity, :category_id
  config.clear_action_items!
  action_item :new do
    link_to 'New Purchase', new_admin_fixed_item_purchase_path
  end
  action_item :new do
    link_to 'Purchase list', admin_fixed_item_purchases_path
  end
  action_item :new do
    link_to 'Assign an Item', new_admin_item_assignment_path
  end
  index do
    column :id
    column :name
    column :category
    column 'Total Quantity', :quantity
    column 'Assigned Quantity', :assigned_quantity
    actions
    # div class: 'my-panel' do
    # h3 "Total items: #{collection.pluck(:quantity).reduce(:+)}"
    # end
  end
  form do |f|
    f.inputs 'Item details' do
      f.input :name, placeholder: 'Enter item name'
      f.input :category_id, label: 'Category', as: :select, collection: FixedItemCategory.all, prompt: 'Select category'
    end
    f.actions do
      f.action :submit
      f.cancel_link(:back)
    end
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :category
          row :quantity
          row :assigned_quantity
        end
      end

      column do
        panel 'Item use history' do
          table_for fixed_item.item_assignment do
            column :employee_id do |i|
              "#{i.employee.first_name.capitalize} #{i.employee.last_name.capitalize}"
            end
            column :quantity
            column(:status) { |item_assignment| status_tag(item_assignment.status) }
          end
        end
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
      @item = FixedItem.new(item_params)
      @first_value = session[:passed_variable]
      if @item.save
        flash[:success] = 'Successfully created new fixed item'
        redirect_to(@first_value)
      else
        super
      end
    end

    def update
      @item = FixedItem.find(params[:id])
      if @item.update(item_params)
        redirect_to admin_fixed_items_path
      else
        flash[:error] = 'Item update unsuccessful'
        redirect_to edit_admin_fixed_item_path
      end
    end

    private

    def item_params
      params.require(:fixed_item).permit(:name, :category_id)
    end
  end

  filter :name
  filter :category_id, label: 'Category', as: :select, collection: proc { FixedItemCategory.all.map { |i| [i.name, i.id] } }
  filter :quantity
end
