FactoryGirl.define do
  factory :evaluation_good_param , class: Evaluation do
    image_id nil
    evaluation true
  end

  factory :evaluation_dup , class: Evaluation do
    image_id nil
    user_id nil
    evaluation true
  end
end
