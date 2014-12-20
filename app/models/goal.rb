class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :goal_categories
  has_many :categories, through: :goal_categories
  has_many :participations
  has_many :participants, through: :participations, class_name: 'User'

  validates :title, presence: true
end
