# frozen_string_literal: true

class SerializableProfile < JSONAPI::Serializable::Resource
  type 'profile'

  attributes :username, :description

  belongs_to :user
  has_one :avatar
end
