# frozen_string_literal: true

module ErrorHandlers::AuthenticationError
  def self.included(base)
    base.class_eval do
      rescue_from ::AuthenticationError, with: :authentication_error
      rescue_from JWT::DecodeError, with: :authentication_error
      rescue_from JWT::ExpiredSignature, with: :authentication_error

      def authentication_error(exceptions)
        render jsonapi_errors: { detail: exceptions.message }, status: 401
      end
    end
  end
end
