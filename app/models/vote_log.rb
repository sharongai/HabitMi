class VoteLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :voucher, class_name: 'User'
  belongs_to :participation

  validates :user, presence: true
  validates :participation, presence: true

  # Adds database validation for making user vote id unique for each day
end
