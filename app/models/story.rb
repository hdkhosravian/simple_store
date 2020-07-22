class Story < ApplicationRecord
  belongs_to :user
  has_one :image, as: :fileable, class_name: 'Attachment', dependent: :destroy

  validates :body, :latitude, :longitude, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  acts_as_votable
  acts_as_commentable
  acts_as_taggable_on :tags

  before_save :save_tags

  def like_counts
    get_likes.count
  end

  private

  def save_tags
    tags = body.downcase.scan(/#(\w+)/).flatten.uniq.join(', ')
    self.tag_list = tags unless tags.empty?
  end
end
