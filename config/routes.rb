Rails.application.routes.draw do
  resources :accounts
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :products do
    resources :products, controller: 'products', only: [:create, :show, :destroy, :update]
    resources :product_categories, controller: 'product_categories'
    resources :product_sizes, controller: 'product_sizes'
    get '/', to: 'products#index'
    get '/user_products/:user_id', to: 'products#user_products'
  end

  namespace :payments do
    post '/:id', to: 'payments#payment'
    put '/approval/:id', to: 'payments#payment_approval'
    get '/:product_id', to:'payments#index'
  end
end
