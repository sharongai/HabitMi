class HomeController < ApplicationController
  def index
    if user_signed_in?
      @goals = Goal.search '*',
        where: { created_at: Time.now.beginning_of_day..Time.now.end_of_day }
    end
  end

  def about_us
  end

  def contact_us
  end

  def search_goals
    respond_to do |format|
      if params[:goal_title].blank?
        @goals = Goal.where(
          created_at: Time.now.beginning_of_day..Time.now.end_of_day)
      else
        @goals = Goal.search_by_title(params[:goal_title])
      end

      format.json do
        render json: {
          html: render_to_string(template: 'home/_goals_list.html.erb',
                                 layout: false)
        }
      end
    end
  end
end
