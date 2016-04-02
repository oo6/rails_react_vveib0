Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'admin_constraint'
  mount Sidekiq::Web => 'sidekiq', :constraints => AdminConstraint.new

  mount API => '/'

  root 'static_pages#home'

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'signup'  => 'users#new'

  post 'signup'  => 'users#create'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'

  get '/auth/:provider/callback', to: 'authentications#callback'

  get '/search' => 'search#index'

  concern :likeable do
    resource :like, only: [:create, :destroy]
  end

  scope path: '/users/:name', as: 'user' do
    root 'users#show', as: ''

    get :following, to: 'users#following', as: 'following'
    get :followers, to: 'users#followers', as: 'followers'

    post :follow, to: 'relationships#create', as: 'follow'
    delete :unfollow, to: 'relationships#destroy', as: 'unfollow'
  end

  resources :account_activations, only: [:index]

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :microposts, only: [:create, :destroy, :show], concerns: [:likeable] do
    get 'last', on: :collection

    resources :comments, only: [:create, :index]

    member do
      get 'get_last_five_comments'
      post :expand, to: 'microposts#create'
    end
  end

  resources :comments, only: [:destroy], concerns: [:likeable] do
    collection do
      get :inbox, :outbox
    end

    member do
      post :reply
      get :ancestors
    end
  end

  resources :notifications, only: [:index, :destroy] do
    collection do
      get :unread, :get_unread_count
    end
  end

  resources :topics, except: [:show]

  scope path: '/topics/:content', as: 'topic' do
    root 'topics#show'
  end

  scope :mentions do
    get :micropost, to: 'mentions#micropost', as: 'micropost_mentions'
    get :comment, to: 'mentions#comment', as: 'comment_mentions'
  end

  scope :likes do
    get :inbox, to: 'likes#inbox', as: 'inbox_likes'
    get :outbox, to: 'likes#outbox', as: 'outbox_likes'
  end

  namespace :settings do
    resource :profile, only: [:show, :update]
    resource :admin, only: [:show, :update, :destroy]
    resource :notifications, only: [:show, :update]
    resource :binds, only: [:show, :update, :destroy]
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
