class CommentsController < ApplicationController
  def create
    @goal = Goal.find(params[:comment][:commentable_id])
    @comment = Comment.build_from(@goal, current_user.id,
                                  params[:comment][:body])

    if @comment.save
      redirect_to @goal
    else
      render 'goals/show'
    end
  end
end
