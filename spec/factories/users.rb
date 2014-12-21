FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@gmail.com" }
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password 'password'
    password_confirmation 'password'
  end
end
