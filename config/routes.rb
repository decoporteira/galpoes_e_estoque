Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :product_models, only: [:index, :new, :create, :show]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do 
    get 'search', on: :collection
  end
end
