require 'rails_helper'

RSpec.describe VoteLog, :type => :model do
  it { should belong_to :user }
  it { should belong_to :participation }
  it { should validate_presence_of :user }
  it { should validate_presence_of :participation }
  it { should validate_uniqueness_of(:user_id).scoped_to(:participation_id) }
end
