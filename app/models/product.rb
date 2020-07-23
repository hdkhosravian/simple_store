class Product < ApplicationRecord
  belongs_to :user
  has_many :variations, dependent: :destroy
  
  has_one :image, as: :fileable, class_name: 'Attachment', dependent: :destroy

  validates :title, :description, :sku, presence: true

end
