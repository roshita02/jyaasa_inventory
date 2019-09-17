# frozen_string_literal: true

Rails.application.routes.draw do
  resources :item_requests
  resources :items
  devise_for :employees, controllers: { sessions: 'employees/sessions', invitations: 'employees_invitation', registrations: 'employees/registrations' }
  resources :vendors
  resources :employee_dashboard
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'categories/:category_id/item_list', to: 'admin/fixed_item_purchases#item_list'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :home
  root to: 'home#index'
  # root to: 'employee_dashboard#index'
  # namespace :employee do
  # root to: 'employee_dashboard#index'
  # end
end
