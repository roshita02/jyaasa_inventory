# frozen_string_literal: true

Rails.application.routes.draw do
  resources :items
  devise_for :employees, controllers: {sessions: 'employees/sessions', invitations: 'employees_invitation' }
  resources :vendors
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :home
  #root to: 'admin/dashboard#index'
  root to: 'employee_dashboard#index'
  namespace :employees do
    root to: 'employee_dashboard#index'
  end
end
