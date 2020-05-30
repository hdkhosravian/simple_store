# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit

  include ErrorHandlers::RecordNotFoundError
  include ErrorHandlers::BadRequestError
  include ErrorHandlers::AuthenticationError
  include ErrorHandlers::UserNotAuthorized
end
