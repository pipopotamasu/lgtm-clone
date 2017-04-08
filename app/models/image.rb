class Image < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :image, presence: true
end
