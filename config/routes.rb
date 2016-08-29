Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products

  get 'search_product', to: 'products#search'
  get 'search_results_product', to: 'products#search_results'
  root 'users#index'

  resources :admins
  get 'sessions/new'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create', as: 'session'
  match 'logout', to: 'sessions#destroy', as: 'logout', via: [:get, :delete]

end
