# frozen_string_literal: true

class OptionPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :params

    def initialize(user, params)
      @user   = user
      @params = params
    end

    def resolve
      options = user.options
      options = options.where(title: params[:title]) if params[:title].present?
      options
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user_authorized?
  end

  def destroy?
    user_authorized?
  end

private

  def user_authorized?
    user.id == record.user_id
  end
end
