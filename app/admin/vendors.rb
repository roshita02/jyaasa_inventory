# frozen_string_literal: true

# ActiveAdmin for Vendor
ActiveAdmin.register Vendor do
  permit_params :name, :pan_no
  index do
    selectable_column
    column :id
    column :name
    column :pan_no
    actions
  end
  show do
    attributes_table do
      row :name
      row :pan_no
      row 'Items' do
        Item.all.where(vendor_id: Vendor.find(params[:id]))
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
      @vendor = Vendor.create(vendor_params)
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
