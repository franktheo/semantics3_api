Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products
  resources :users

  get 'search_product', to: 'products#search'
  get 'search_background', to: 'products#search_background'
  get 'search_results_product', to: 'products#search_results'
  get 'search_results_background', to: 'products#search_results_background'
  get 'admin_page', to: 'products#admin_page'

  resources :admins
  get 'sessions/new'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'session'
  match 'logout', to: 'sessions#destroy', as: 'logout', via: [:get, :delete]
  root 'products#index'

end
