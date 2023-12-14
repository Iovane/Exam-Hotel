Rails.application.routes.draw do
  resources :hotels do
    resources :rooms, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :rooms  do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings do
    get 'user_bookings', to: 'bookings#index'
  end


  devise_for :users
  root 'pages#home'

end
