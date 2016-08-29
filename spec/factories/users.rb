FactoryGirl.define do
  factory :user do
    factory :admin do
      sequence(:username){|n| "admin#{n}"}
      role 'admin'
    end
    factory :guest do
      sequence(:username){|n| "guest#{n}"}
      role 'guest'
    end
  end
end
