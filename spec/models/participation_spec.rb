require 'rails_helper'

RSpec.describe Participation, :type => :model do
  it { should belong_to :user }
  it { should belong_to :goal }
  it { should validate_presence_of :user }
  it { should validate_presence_of :goal }
end
