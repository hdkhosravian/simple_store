class Variation < ApplicationRecord
  belongs_to :product
  has_many :variations

  has_one :image, as: :fileable, class_name: 'Attachment', dependent: :destroy

  validates :price, :quantity, :sku, presence: true
end
