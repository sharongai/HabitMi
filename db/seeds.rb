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

# Create Categories
['Health', 'Fitness', 'Social', 'Self-Improvement', 'Relationships',
 'Education'].each do |category_name|
  Category.create name: category_name
end
