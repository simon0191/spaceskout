require 'sidekiq/web'

Rails.application.routes.draw do

  get '/ping', to: proc { [200, {}, ['Ok']] }

  devise_for :users, only: [:sessions, :password, :confirmations]
  devise_for :customers, controllers: {registrations: 'customers/registrations'}, only: [:registrations]
  devise_for :space_owners, controllers: {registrations: 'space_owners/registrations'}, only: [:registrations]
  devise_for :admins, controllers: {registrations: 'admins/registrations'}, only: [:registrations]

  root 'pages#home'

  authenticate :user, lambda { |u| u.is_a? Admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :pages, path: '/', only: [] do
    collection do
      get :your_space_here
      get :our_story
      get :contact_us
      get :privacy
      # get :faqs
      get :community_giveback
      get :terms_of_service
    end
  end

  resources :donations, only: [:create]

  resources :spaces, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  resources :messages, only: [:create]

  namespace :dashboard do
    get '/', to: redirect('/space_owners/edit'), as: :root
    resources :spaces, only: [:index, :new, :create, :edit, :update, :destroy] do
      member do
        patch :publish
      end
    end
    resources :plans, only: [:index, :edit, :update] do
      member do
        get :validate_coupon
      end
      resources :subscriptions, only: [:new, :create] do
      end
    end
    resources :messages, only: [:index, :show] do
      member do
        post :reply
      end
    end
    resource :charity, only: [:edit, :update]
    resources :coupons, only: [:index, :edit, :update, :new, :create] do
      member do
        patch :deactivate
        patch :activate
      end
    end
  end

end
