class Option < ApplicationRecord
  belongs_to :user
  has_many :variation_options, dependent: :destroy

  validates :title, :description, presence: true

  enum title: %i(color option_size pattern shape)
end
