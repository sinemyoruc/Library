Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources :books do
    resources :comments
  end

  get 'like', to: 'books#like'

end
