# frozen_string_literal: true

class SerializableVariation < JSONAPI::Serializable::Resource
  type 'variation'

  attributes :price, :quantity, :sku

  belongs_to :product
  has_one :image
end
