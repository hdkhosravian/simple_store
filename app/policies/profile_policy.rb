# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user.id == profile.user.id
  end

private

  def profile
    record
  end
end
