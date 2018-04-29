Rails.application.routes.draw do
  devise_for :users, controllers: {
  	sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations',
  }
  authenticated :user do
    root 'home#index', as: :authenticated_root
  end
  get 'users/index'
  get 'home/index'
  get 'home/chat'
  root to: 'home#index'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
