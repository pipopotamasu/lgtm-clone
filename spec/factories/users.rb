FactoryGirl.define do
  factory :user do
    name "Example User"
    email "user@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  # factory_girlは引数を見て暗黙的に使用
  factory :user_admin , class: User do
    name "Admin User"
    email "admin@example.com"
    password "foobar"
    password_confirmation "foobar"
    admin true
  end

  factory :user_2 , class: User do
    name "Example User2"
    email "user2@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :user_admin_2 , class: User do
    name "Admin User2"
    email "admin2@example.com"
    password "foobar"
    password_confirmation "foobar"
    admin true
  end
end
