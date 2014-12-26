module UsersHelper
  def user_missing_profile_picture?(file_name)
    'user-missing-profile-picture' if file_name.match(/user_icon.png/)
  end

  def user_active_goals(user)
    if user.goals.count > 0
      "Active in #{pluralize(user.goals.count, 'Goal')}"
    else
      '0 Goals'
    end
  end
end
