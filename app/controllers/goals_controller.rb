class GoalsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :destroy, :create]
  before_action :find_goal, only: [:show, :destroy, :invite]

  def show
  end

  def new
    params[:page] ||= 1
    @goal = current_user.goals.new
    @categories = Category.all
    @users = User.where.not(id: current_user.id).page(params[:page]).per(4)
  end

  def destroy
    @goal.destroy
    redirect_to root_path
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if params[:category_ids].blank?
      @goal.errors.add(:base, 'You need to select Categories')
      @categories = Category.all
      @users = User.where.not(id: current_user.id).page(params[:page]).per(4)
      render :new
    elsif @goal.save
      params[:category_ids].each { |id| @goal.categories << Category.find(id) }
      params[:user_ids].each do |user_id|
        user = User.find(user_id)
        @goal.participants << user
        @goal.save
        UserMailer.delay.invite_people_to_goal(user, @goal)
      end
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
    params.require(:goal).permit(:title, :start_date)
  end

  def find_goal
    @goal = Goal.friendly.find(params[:id])
  end
end
