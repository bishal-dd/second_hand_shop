Rails.application.routes.draw do
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
    get '/:id', to: 'payments#index'
    get '/earnings/:user_id', to: 'payments#total_payment_amount'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }

  devise_scope :user do
    post '/add_admin', to: 'users/registrations#add_admin'
  end
  # Move this route outside the devise_scope block
  get '/current_user', to: 'users/current_user#fetch_current_user'

  resources :accounts, except: [:create, :index] do
    post '/:id', to: 'accounts#create', on: :collection, as: :create
    get '/:id', to: 'accounts#index', on: :collection, as: :index

  end
  end
