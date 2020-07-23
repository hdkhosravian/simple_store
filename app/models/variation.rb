class Variation < ApplicationRecord
  belongs_to :product
  has_many :variation_options, dependent: :destroy

  has_one :image, as: :fileable, class_name: 'Attachment', dependent: :destroy

  validates :price, :quantity, :sku, presence: true

  validate :max_option_size

  private

  def max_option_size
    errors.add(:base, "variation can not have more than 4 options") if variation_options.size > 4
  end
end
