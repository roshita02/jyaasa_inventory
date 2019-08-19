# frozen_string_literal: true

# ActiveAdmin for Vendor
ActiveAdmin.register Vendor do
  permit_params :name, :pan_no
  show do 
    attributes_table do
      row :name
      row :pan_no
      row 'Items' do
        Item.all.where(vendor_id: Vendor.find(params[:id]))
      end
    end
  end
end
