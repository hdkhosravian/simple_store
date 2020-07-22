# frozen_string_literal: true

class User::ResetPasswordService
  def initialize(params)
    @params = params
  end

  def process
    result = true
    errors = nil
    user   = nil

    reset_password_token = Devise.token_generator.digest(
      User, :reset_password_token, @params[:token]
    )
    user = User.find_by(reset_password_token: reset_password_token)

    unless user.present?
      return render_result(
        !result,
        user,
        detail: I18n.t('api.v1.session.reset_password.invalid_reset_password_token'),
      )
    end

    unless @params[:password].eql? @params[:password_confirmation]
      return render_result(
        !result,
        user,
        detail: I18n.t('messages.authentication.equal_password'),
      )
    end

    ::User.transaction do
      user.password             = @params[:password]
      user.reset_password_token = nil
      result                    = user.save!
      errors                    = user.errors.messages
      result                    = false if errors.present?
    end

    render_result(result, user, errors)
  end

private

  def render_result(result, user, errors)
    { result: result, user: user, errors: errors }
  end
end
