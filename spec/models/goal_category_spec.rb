require 'rails_helper'

RSpec.describe GoalCategory, :type => :model do
  it { should belong_to :goal }
  it { should belong_to :category }
  it { should validate_presence_of :goal }
  it { should validate_presence_of :category }
  it { should validate_uniqueness_of(:category_id).scoped_to(:goal_id) }
end
