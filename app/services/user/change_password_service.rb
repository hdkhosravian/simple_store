# frozen_string_literal: true

class User::ChangePasswordService
  def initialize(params, user)
    @current_user = user
    @params       = params
  end

  def process
    result = true
    errors = nil

    unless @current_user.present? && @current_user.valid_password?(@params[:password])
      return render_result(
        !result,
        detail: I18n.t('api.v1.users.change_password.incorrect_password'),
      )
    end

    unless @params[:new_password].eql? @params[:new_password_confirmation]
      return render_result(
        !result,
        detail: I18n.t('api.v1.users.change_password.not_equal_new_passwords'),
      )
    end

    ::User.transaction do
      @current_user.update!(
        password: @params[:new_password],
        password_confirmation: @params[:new_password],
      )
      errors = @current_user.errors.messages
      result = false if errors.present?
    end

    render_result(result, errors)
  end

private

  def render_result(result, errors)
    { result: result, errors: errors }
  end
end
