Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :products do
    resources :products, controller: 'products'
    resources :product_categories, controller: 'product_categories'
  end
end
