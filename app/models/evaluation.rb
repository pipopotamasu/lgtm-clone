class Evaluation < ApplicationRecord
  belongs_to :image
  belongs_to :user
  validates :image_id, presence: true
  validates :user_id, presence: true
  validates :evaluation, presence: true
end
