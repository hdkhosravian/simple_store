# frozen_string_literal: true

module Api
  module V1
    module Users
      class ForgotPasswordsController < Api::V1::ApiController
        def create
          param! :email, String, required: true, blank: false

          @user = User.find_by!(email: params[:email])
          @user.send_reset_password_instructions

          message = {
            detail: I18n.t('api.v1.session.forgot_password.success'),
          }

          render json: message, status: 200
        end

        def update
          param! :token, String, required: true, blank: false
          param! :password, String, required: true, blank: false
          param! :password_confirmation, String, required: true, blank: false

          result = User::ResetPasswordService.new(params).process

          if result[:result]
            message = { detail: I18n.t('api.v1.session.reset_password.success') }
            render json: message, status: 200
          else
            @errors = result[:errors]
            render jsonapi_errors: result[:errors], status: 400
          end
        end
      end
    end
  end
end
