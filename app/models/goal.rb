class Goal < ActiveRecord::Base
  acts_as_commentable

  include PgSearch
  pg_search_scope :search_by_title, against: :title

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :goal_categories, dependent: :destroy
  has_many :categories, through: :goal_categories
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user,
    class_name: 'User'

  validates :user, presence: true
  validates :title, presence: true
  validates :start_date, presence: true

  before_save :set_end_date
  after_create :add_user_as_participant

  scope :started, -> { where 'start_date < ?', DateTime.now }
  scope :not_started, -> { where 'start_date >= ?', DateTime.now }

  def started?
    self.start_date < DateTime.now
  end

  def days_left
    (self.end_date.to_date - Date.today).to_i
  end

  private

  def set_end_date
    self.end_date = self.start_date + 66.days
  end

  def add_user_as_participant
    participations.create(user: user)
  end
end
