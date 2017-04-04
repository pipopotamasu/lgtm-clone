FactoryGirl.define do
  factory :user do
    id 1
    name "Example User"
    email "user@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
