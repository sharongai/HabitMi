class GoalsController < ApplicationController
  before_action :find_goal, only: [:show, :invite]

  def show
  end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      goal_params[:category_ids].each do |category_id|
        @goal.goal_categories.create(category_id: category_id)
      end

      redirect_to invite_goal_path(@goal)
    else
      render :new
    end
  end

  def invite

  end
  private

  def goal_params
    params.require(:goal).permit(:title, :start_date, category_ids: [])
  end

  def find_goal
    @goal = Goal.friendly.find(params[:id])
  end
end
