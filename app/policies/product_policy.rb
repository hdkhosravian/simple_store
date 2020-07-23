# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  def index?
    true
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
