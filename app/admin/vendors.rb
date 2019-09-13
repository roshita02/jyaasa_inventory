# frozen_string_literal: true

# ActiveAdmin for Vendor
ActiveAdmin.register Vendor do
  menu priority: 7
  permit_params :name, :pan_no
  index do
    column :id
    column :name
    column :pan_no
    actions
  end
  show do
    columns do
      column do
        attributes_table do
          row :name
          row :pan_no
          # row 'Items' do
          # FixedItemPurchase.all.where(vendor_id: Vendor.find(params[:id]))
          # NonFixedItemPurchase.all.where(vendor_id: Vendor.find(params[:id]))
          # end
        end
      end

      column do
        panel 'Purchased Items history' do
          table_for vendor.purchase do
            column :purchased_date
            column :item
            column :category
            column :quantity
            column :rate
          end
        end
      end
    end
  end

  form do |f|
    f.inputs 'New Item' do
      f.input :name
      f.input :pan_no
    end
    f.actions do
      f.action :submit
      f.cancel_link(:back)
    end
  end

  controller do
    def new
      @vendor = Vendor.new
      @first_value = request.referer
      session[:passed_variable] = @first_value
    end

    def create
      @vendor = Vendor.new(vendor_params)
      @first_value = session[:passed_variable]
      if @vendor.save
        flash[:success] = 'Successfully created new vendor'
        redirect_to(@first_value)
      else
        render :new
      end
    end

    private

    def vendor_params
      params.require(:vendor).permit(:name, :pan_no)
    end
  end
end
