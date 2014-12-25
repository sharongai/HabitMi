class UserMailer < ActionMailer::Base
  default from: 'habitmi@gmail.com'

  def invite_people_to_goal(user, goal)
    @user = user
    @goal = goal
    mail(to: @user.email, subject: 'Join this goal!')
  end
end
