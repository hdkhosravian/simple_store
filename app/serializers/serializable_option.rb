# frozen_string_literal: true

class SerializableOption < JSONAPI::Serializable::Resource
  type 'option'

  attributes :title, :description

  belongs_to :user
end
