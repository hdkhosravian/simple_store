# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Api::V1::ApiController
        def create
          param! :email, String, required: true, blank: false
          param! :password, String, required: true, blank: false

          @user = User.find_by(email: params[:email].downcase)

          if @user.present? && @user.valid_password?(params[:password])
            User::AuthService.create_token(@user, request)
            render jsonapi:
              @user, include: %w(last_token), fields: { user: [:email] }
          else
            errors = { detail: I18n.t('api.v1.session.sign_in.error') }
            render jsonapi_errors: errors, status: 400
          end
        end

        def update
          param! :refresh_token, String, required: true, blank: false

          @user = refresh_user!(params[:refresh_token], request)

          render jsonapi:
            @user, include: %w(last_token), fields: { user: [:email] }
        end

        def destroy
          logout_user!
          render json: { detail: I18n.t('api.v1.users.logout') }
        end
      end
    end
  end
end
