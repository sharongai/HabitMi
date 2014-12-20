class GoalCategory < ActiveRecord::Base
  belongs_to :goal
  belongs_to :category

  validates :goal, presence: true
  validates :category, presence: true
end
