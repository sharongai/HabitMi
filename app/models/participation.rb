class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  validates :score, presence: true
  validates :user, presence: true
  validates :goal, presence: true
  validates :user_id, uniqueness: { scope: :goal_id }
end
