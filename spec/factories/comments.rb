FactoryGirl.define do
  factory :comment do
    association :user, factory: :user, strategy: :create
    association :commentable, factory: :goal, strategy: :create
    body Faker::Lorem.paragraph
  end
end
