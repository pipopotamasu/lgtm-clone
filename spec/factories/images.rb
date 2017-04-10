# なんだこれは?
# TODO:とりあえず源流にはRackというwebサーバ間のインターフェイスがあるっぽいからそこから調べる
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :image do
    image { fixture_file_upload('spec/factories/images/test.png', 'image/png') }
    user_id nil
  end

  factory :image_already_created , class: Image do
    image { fixture_file_upload('spec/factories/images/test.png', 'image/png') }
    association :user, factory: :user
  end
end
