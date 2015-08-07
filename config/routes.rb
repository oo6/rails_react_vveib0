Rails.application.routes.draw do
  root 'static_pages#home'

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'signup'  => 'users#new'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  get '/auth/:provider/callback', to: 'authentications#callback'

  concern :likeable do
    resource :like, only: [:create, :destroy]
  end

  resources :users, except: [:index] do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :microposts, only: [:create, :destroy, :show], concerns: [:likeable] do
    get 'last', on: :collection

    resources :comments, only: [:create]

    get 'get_last_five_comments', on: :member
  end

  resources :comments, only: [:destroy], concerns: [:likeable]

  resources :relationships, only: [:create, :destroy]

  resources :notifications, only: [:index, :destroy] do
    collection do
      get :unread, :get_unread_count, :comment, :mention, :like
    end
  end

  namespace :admin do
    root to: 'dashboard#past_day'

    get 'past_day', to: 'dashboard#past_day'

    get 'past_day_users_count', to: 'dashboard#past_day_users_count'

    get 'past_week', to: 'dashboard#past_week'

    get 'past_week_users_count', to: 'dashboard#past_week_users_count'

    get 'past_month', to: 'dashboard#past_month'

    get 'past_month_users_count', to: 'dashboard#past_month_users_count'

    get 'past_year', to: 'dashboard#past_year'

    get 'past_year_users_count', to: 'dashboard#past_year_users_count'
  end
end
