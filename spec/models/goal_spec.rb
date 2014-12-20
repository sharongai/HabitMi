require 'rails_helper'

RSpec.describe Goal, :type => :model do
  it { should belong_to :user }
  it { should have_many(:goal_categories) }
  it { should have_many(:categories).through(:goal_categories) }
  it { should have_many :participations }
  it { should have_many(:participants).through(:participations).
       class_name('User') }

  it { should validate_presence_of :title }
end
