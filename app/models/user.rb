class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  has_many :selected_categories, dependent: :destroy
  has_many :categories, through: :selected_categories
  has_many :vote_logs, dependent: :destroy
  has_many :goals
  has_many :participations, dependent: :destroy
  has_many :participating_goals, through: :participations, source: :goal,
    class_name: 'Goal'

  has_attached_file :profile_picture,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/profile_pictures/:style/user_icon.png"

  validates_attachment :profile_picture,
    content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/gif',
                                   'image/png'] }, size: { in: 0..2.megabytes }

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.from_omniauth(auth)
    found_user = self.find_by(email: auth.info.email)

    if found_user.present?
      found_user.update_attributes(
        uid: auth.uid,
        provider: auth.provider,
        oauth_token: auth.credentials.token,
        oauth_expires_at: Time.at(auth.credentials.expires_at)
      )
      found_user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.uid = auth.uid
        user.provider = auth.provider
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        # user.image = auth.info.image # assuming the user model has an image
      end
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def voted?(goal)
    vote_log = vote_logs.find_by(
      created_at: Time.now.beginning_of_day..Time.now.end_of_day,
      vouched: false, user: self, voucher: self)
    vote_log.present? && (vote_log.participation.goal == goal)
  end

  def vouched?(user, goal)
    vote_log = vote_logs.find_by(
      created_at: Time.now.beginning_of_day..Time.now.end_of_day,
      vouched: true, user: self, voucher: user)

    vote_log.present? && (vote_log.participation.goal == goal)
  end
end
