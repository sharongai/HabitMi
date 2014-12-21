FactoryGirl.define do
  factory :goal do
    association :user, factory: :user, strategy: :create
    title Faker::Hacker.noun
    start_date DateTime.now + (1..5).to_a.sample.days
  end
end
