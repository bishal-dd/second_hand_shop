Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :products do
    resources :products, controller: 'products'
    resources :product_categories, controller: 'product_categories'
    resources :product_sizes, controller: 'product_sizes'
  end
end
