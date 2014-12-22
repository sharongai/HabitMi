class ParticipationsController < ApplicationController
  def create
    current_user.participations.create(goal_id: params[:goal_id])
    redirect_to Goal.find(params[:goal_id])
  end

  def destroy
    Participation.find_by(goal_id: params[:goal_id], user: current_user).destroy
    redirect_to Goal.find(params[:goal_id])
  end
end
