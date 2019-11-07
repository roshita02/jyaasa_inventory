# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  menu label: 'Admins', priority: 9
  permit_params :email, :password, :password_confirmation
  index do
    column :email
    column :created_at do |i|
      i.created_at.to_date
    end
    actions
  end

  show do
    columns do
      column max_width: '666px' do
        attributes_table do
          row :email
          row :created_at do |i|
            i.created_at.to_date
          end
        end
      end
    end
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs 'Admin details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
