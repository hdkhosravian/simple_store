# frozen_string_literal: true

class SerializableProduct < JSONAPI::Serializable::Resource
  type 'story'

  attributes :title, :description, :sku

  belongs_to :user
  has_one :image
  has_many :options
end
