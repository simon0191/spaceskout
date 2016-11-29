Rails.application.routes.draw do

  devise_for :users, only: [:sessions, :password, :confirmations]
  devise_for :customers, controllers: {registrations: 'customers/registrations'}, only: [:registrations]
  devise_for :space_owners, controllers: {registrations: 'space_owners/registrations'}, only: [:registrations]

  root 'pages#home'

  resources :pages, path: '/', only: [] do
    collection do
      get :your_space_here
      get :our_story
      get :contact_us
      get :privacy
      get :faqs
      get :community_giveback
    end
  end

  resources :spaces, only: [:index, :show]
  resources :messages, only: [:create]

  namespace :dashboard do
    get '/', to: redirect('/space_owners/edit'), as: :root
    resources :spaces, only: [:index, :new, :create, :edit, :update] do
      member do
        patch :publish
      end
    end
    resources :plans, only: [:index] do
      member do
        get :validate_coupon
      end
      resources :subscriptions, only: [:new, :create] do
      end
    end
  end

end
