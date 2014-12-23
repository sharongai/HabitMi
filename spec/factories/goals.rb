FactoryGirl.define do
  factory :goal do
    association :user, factory: :user, strategy: :create
    title Faker::Hacker.noun
    start_date DateTime.now + (1..5).to_a.sample.days

    factory :goal_with_categories do
      after(:create) do |goal|
        (1..3).to_a.sample.times do
          goal.categories << FactoryGirl.create(:category)
        end
      end
    end
  end
end
