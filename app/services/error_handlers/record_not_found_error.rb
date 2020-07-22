# frozen_string_literal: true

module ErrorHandlers::RecordNotFoundError
  def self.included(base)
    base.class_eval do
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error

      def record_not_found_error(exceptions)
        render jsonapi_errors: { detail: exceptions.message }, status: 404
      end
    end
  end
end
