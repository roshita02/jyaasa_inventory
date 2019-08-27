# frozen_string_literal: true

Rails.application.routes.draw do
  resources :item_requests
  resources :items
  devise_for :employees, controllers: { sessions: 'employees/sessions', invitations: 'employees_invitation' }
  resources :vendors
  resources :employee_dashboard
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :home
  root to: 'home#index'
  # root to: 'employee_dashboard#index'
  # namespace :employee do
  # root to: 'employee_dashboard#index'
  # end
end
