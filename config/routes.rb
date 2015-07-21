Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'signup'  => 'users#new'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  resources :users, except: [:index] do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :microposts, only: [:create, :destroy] do
    get 'last', on: :collection
  end

  resources :relationships, only: [:create, :destroy]

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
