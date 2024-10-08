Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  scope :api do
    resources :books, except: :put do
      get :download, to: 'downloads#show'
    end

    resources :authors, except: :put
    resources :publishers, except: :put
    resources :users, except: :put

    get '/search/:text', to: 'search#index'

    resources :user_confirmations, only: :show, param: :confirmation_token
    resources :password_resets, only: [:show, :create, :update],
              param: :reset_token

    resources :access_tokens, only: :create do
      delete '/', action: :destroy, on: :collection
    end

    resources :purchases, only: [:index, :show, :create]

  end

  root to: 'books#index'
end
