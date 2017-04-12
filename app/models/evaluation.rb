class Evaluation < ApplicationRecord
  belongs_to :image
  belongs_to :user
  validates :image_id, presence: true
  validates :user_id, presence: true, :uniqueness => {:scope => :image_id} # 複合ユニークあり
  validates :evaluation, presence: true
end
