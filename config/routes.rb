# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees, controllers: { invitations: 'employees_invitations' }
  resources :vendors
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :home
  root 'home#index'
end
