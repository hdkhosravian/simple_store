# frozen_string_literal: true

class User::RegistrationService
  def initialize(params)
    @params = params
  end

  def process
    result = true
    errors = nil
    user   = nil

    unless @params[:password].eql? @params[:password_confirmation]
      return render_result(
        !result,
        user,
        detail: I18n.t('messages.authentication.equal_password'),
      )
    end

    ::User.transaction do
      user          = ::User.new
      user.email    = @params[:email]
      user.password = @params[:password]
      user.save
      errors        = user.errors.messages
      result        = false if errors.present?
    end

    render_result(result, user, errors)
  end

private

  def render_result(result, user, errors)
    { result: result, user: user, errors: errors }
  end
end
