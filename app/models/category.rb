class Category < ActiveRecord::Base
  has_many :goal_categories
  has_many :goals, through: :goal_categories
  has_many :selected_categories
  has_many :users, through: :selected_categories

  validates :name, presence: true
end
