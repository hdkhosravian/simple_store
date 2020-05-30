# frozen_string_literal: true

module ErrorHandlers::UserNotAuthorized
  def self.included(base)
    base.class_eval do
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      def user_not_authorized
        render jsonapi_errors: { detail: I18n.t('messages.http._403') }, status: 403
      end
    end
  end
end
