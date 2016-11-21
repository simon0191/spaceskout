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

  resources :spaces, only: [:index]

  namespace :dashboard do
    resources :spaces
  end

end
