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
end
