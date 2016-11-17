Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  resources :pages, only: [] do
    collection do
      get :home
      get :how_it_works
    end
  end
end
