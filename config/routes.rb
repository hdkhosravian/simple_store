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
      resources :bootcamps do
        resources :bootcamp_courses do
          resources :workbooks, path: ':workbookable_type/:workbookable_id/workbooks'
        end
        resources :roles
      end
      resources :courses do
        resources :lessons do
          resources :items do
            resources :videos
            resources :codes
            resources :contents
            resources :quizzes do
              resources :questions do
                resources :options
              end
            end
            resources :documents
          end
        end
      end
    end
  end
end
