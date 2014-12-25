# Create Categories
['Self Improvement', 'Studying', 'Being on Time', 'New Diet', 'New Diet',
 'Exercise', 'Learn a New Skill'].each do |category_name|
  Category.create name: category_name
end

# Create Users
chris = User.create email: 'chris@gmail.com',
                    first_name: 'Chris',
                    last_name: 'Jeon',
                    password: 'password',
                    password_confirmation: 'password'

kai = User.create email: 'kai@gmail.com',
                  first_name: 'Kai',
                  last_name: 'Wang',
                  password: 'password',
                  password_confirmation: 'password'

nina = User.create email: 'nina@gmail.com',
                   first_name: 'Nina',
                   last_name: 'Yang',
                   password: 'password',
                   password_confirmation: 'password'

sharon = User.create email: 'sharon@gmail.com',
                     first_name: 'Sharon',
                     last_name: 'Gai',
                     password: 'password',
                     password_confirmation: 'password'

# Create Random Users
50.times do
  User.create email: Faker::Internet.email,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              password: 'password',
              password_confirmation: 'password'
end

# Create Selected Categories for Users
User.all.each do |user|
  (1..3).to_a.sample.times do
    category = Category.all.sample
    until user.categories.exclude? category
      category = Category.all.sample
    end
    user.categories << category
    user.save
  end
end

# Create Goals
10.times do
  goal = Goal.create title: Faker::Company.catch_phrase,
                     user: [chris, kai, nina, sharon].sample,
                     start_date: DateTime.now + (1..7).to_a.sample.days

  (1..3).to_a.sample.times do
    new_category =
      Category.where.not(id: goal.goal_categories.pluck(:category_id)).sample
    goal.goal_categories.create(category: new_category)
  end
end

# Create Goal Categories
Goal.all.each do |goal|
  (1..3).to_a.sample.times do
    category = Category.all.sample
    until goal.categories.exclude? category
      category = Category.all.sample
    end
    goal.categories << category
    goal.save
  end
end

# Create Goal Participants
Goal.all.each do |goal|
  5.times do
    new_participant =
      User.where.not(id: goal.participants.pluck(:user_id)).sample
    goal.participations.create(user: new_participant)
  end
end
