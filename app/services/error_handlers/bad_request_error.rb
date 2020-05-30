# frozen_string_literal: true

module ErrorHandlers::BadRequestError
  def self.included(base)
    base.class_eval do
      rescue_from RailsParam::Param::InvalidParameterError, with: :bad_request_error
      rescue_from RuntimeError, with: :bad_request_error

      def bad_request_error(exceptions)
        render jsonapi_errors: { detail: exceptions.message }, status: 400
      end
    end
  end
end
