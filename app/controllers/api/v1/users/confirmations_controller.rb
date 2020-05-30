# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < Api::V1::ApiController
        def create
          param! :token, String, required: true, blank: false

          @user = User.find_by!(confirmation_token: params[:token])
          @user.confirm

          message = { detail: I18n.t('api.v1.registration.confirmation.success') }
          render json: message, status: 200
        end

        def update
          param! :email, String, required: true, blank: false

          @user = User.find_by!(email: params[:email])
          @user.send_confirmation_instructions

          message = { detail: I18n.t('api.v1.registration.resend_confirmation.success') }
          render json: message, status: 200
        end
      end
    end
  end
end
