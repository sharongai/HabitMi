class GoalsController < ApplicationController
  before_action :find_goal, only: [:show, :invite]

  def show
  end

  def new
    params[:page] ||= 1
    @goal = current_user.goals.new
    @categories = Category.all
    @users = User.where.not(id: current_user.id).page(params[:page]).per(4)
  end

  def create
    @goal = current_user.goals.new(goal_params)
    goal_params[:category_ids].each do |id|
      @goal.categories << Category.find(id)
    end

    if @goal.save
      redirect_to @goal
    else
      @categories = Category.all
      @users = User.where.not(id: current_user.id).page(params[:page]).per(4)
      render :new
    end
  end

  def show_more_strangers
    params[:page] = params[:page].to_i + 1
    @users = User.where.not(id: current_user.id).page(params[:page]).per(4)

    respond_to do |format|
      format.json do
        render json: {
          html: render_to_string(template: 'goals/_invite_strangers.html.erb',
                                 layout: false)
        }
      end
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :start_date, category_ids: [],
                                 users: [])
  end

  def find_goal
    @goal = Goal.friendly.find(params[:id])
  end
end
