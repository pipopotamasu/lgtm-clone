FactoryGirl.define do
  factory :image do
    image "test.jpg"
    user_id nil
  end

  factory :image_already_created , class: Image do
    image "test.jpg"
    association :user, factory: :user
  end
end
