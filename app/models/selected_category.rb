class SelectedCategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :user, presence: true
  validates :category, presence: true
  validates :category_id, uniqueness: { scope: :user_id }
end
