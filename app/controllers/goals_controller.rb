class GoalsController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        render json: {
          text: "hello there"
        }
      end
    end
  end
end
