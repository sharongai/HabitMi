class GoalCategory < ActiveRecord::Base
  belongs_to :goal
  belongs_to :category

  validates :goal, presence: true
  validates :category, presence: true

  validates :category_id, uniqueness: { scope: :goal_id }
end
