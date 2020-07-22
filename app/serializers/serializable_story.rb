# frozen_string_literal: true

class SerializableStory < JSONAPI::Serializable::Resource
  type 'story'

  attributes :body, :latitude, :longitude, :like_counts

  belongs_to :user
  has_one :image

  attribute :is_liked? do
    @current_user.voted_for? @object
  end
end
