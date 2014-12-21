class HomeController < ApplicationController
  def index
    if user_signed_in?
      @goals = Goal.where(
        created_at: Time.now.beginning_of_day..Time.now.end_of_day)
    end
  end

  def about_us
  end

  def contact_us
  end
end
