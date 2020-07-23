Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      namespace :users do
        # user authentication
        resource :registrations, only: [:create]
        resource :sessions, only: [:create, :update, :destroy]
        resource :forgot_passwords, only: [:create, :update]
        resource :change_password, only: [:update]
        resource :confirmations, only: [:create, :update]
      end

      resources :profiles, only: %i(show update)
      resources :attachments, only: %i(show)
      resources :products do
        resources :variations
      end
    end
  end
end
