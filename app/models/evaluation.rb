class Evaluation < ApplicationRecord
  belongs_to :image_id, class_name: "Image"
  belongs_to :user_id, class_name: "User"
  validates :image_id, presence: true
  validates :user_id, presence: true
end
