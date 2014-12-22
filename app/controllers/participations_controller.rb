class ParticipationsController < ApplicationController
  def create
    current_user.participations.create(goal_id: params[:goal_id])
    redirect_to Goal.find(params[:goal_id])
  end

  def destroy
    Participation.find_by(goal_id: params[:goal_id], user: current_user).destroy
    redirect_to Goal.find(params[:goal_id])
  end

  def score
    @participation = Participation.find(params[:id])
    @participation.score += 100
    @participation.save
    redirect_to @participation.goal
  end

  def vouch
    @participation = Participation.find(params[:id])
    @participation.score += 25
    @participation.save
    redirect_to @participation.goal
  end
end