# frozen_string_literal: true

class SerializableProfile < JSONAPI::Serializable::Resource
  type 'profile'

  attributes :first_name, :last_name, :phone_number, :description

  belongs_to :user
  belongs_to :avatar
end
