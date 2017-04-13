class Evaluation < ApplicationRecord
  GOOD = true
  BAD = false

  belongs_to :image
  belongs_to :user
  validates :image_id, presence: true
  validates :user_id, presence: true, :uniqueness => {:scope => :image_id} # 複合ユニークあり
end
