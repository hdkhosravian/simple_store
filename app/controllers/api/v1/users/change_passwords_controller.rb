# frozen_string_literal: true

module Api
  module V1
    module Users
      class ChangePasswordsController < Api::V1::ApiController
        before_action :authenticate!

        def update
          result = User::ChangePasswordService.new(user_params, current_user).process

          if result[:result]
            render json: { detail: I18n.t('api.v1.users.change_password.success') },
                   status: :accepted
          else
            errors = result[:errors][:detail].present? ? result[:errors] : { detail: result[:errors] }
            render jsonapi_errors: errors, status: 400
          end
        end

      private

        def user_params
          params.require(:user).permit(
            :password, :new_password,
            :new_password_confirmation
          )
        end
      end
    end
  end
end
