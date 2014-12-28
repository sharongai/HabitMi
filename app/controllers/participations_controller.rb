class ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.participations.create(goal_id: params[:goal_id])
    redirect_to Goal.find(params[:goal_id])
  end

  def destroy
    @participation = Participation.find(params[:id])
    @goal = @participation.goal
    @participation.destroy
    redirect_to @goal
  end

  def score
    @participation = Participation.find(params[:id])
    @participation.score += 100
    @participation.save
    @participation.vote_logs.create(user: current_user, voucher: current_user,
                                    vouched: false)
    redirect_to @participation.goal
  end

  def vouch
    @participation = Participation.find(params[:id])
    @participation.score += 25
    @participation.save
    @participation.vote_logs.create(user_id: params[:participant_id],
                                    voucher: current_user,
                                    vouched: true)
    redirect_to @participation.goal
  end
end
