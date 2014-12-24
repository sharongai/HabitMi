FactoryGirl.define do
  factory :participation do
    association :user, factory: :user, strategy: :create
    association :goal, factory: :goal, strategy: :create
  end
end
