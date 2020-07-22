# frozen_string_literal: true

class SerializableStory < JSONAPI::Serializable::Resource
  type 'comment'

  attributes :body,

  belongs_to :user
end
