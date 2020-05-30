# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Api::V1::ApiController
        def create
          param! :email, String, required: true, blank: false
          param! :password, String, required: true, blank: false
          param! :password_confirmation, String, required: true, blank: false

          result = User::RegistrationService.new(params).process

          if result[:result]
            message = { detail: I18n.t('api.v1.registration.sign_up.success') }
            render json: message, status: 201
          else
            errors = result[:errors][:detail].present? ? result[:errors] : { detail: result[:errors] }
            render jsonapi_errors: errors, status: 400
          end
        end
      end
    end
  end
end
