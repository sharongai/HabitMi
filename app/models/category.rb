class Category < ActiveRecord::Base
  has_many :goal_categories
  has_many :goals, through: :goal_categories
  has_many :selected_categories
  has_many :users, through: :selected_categories

  has_attached_file :icon_image,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment :icon_image,
    content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/gif',
                                   'image/png'] }, size: { in: 0..2.megabytes }

  validates :name, presence: true
end
