require 'rails_helper'

RSpec.describe Category, :type => :model do
  it { should have_many :goal_categories }
  it { should have_many(:goals).through(:goal_categories) }
  it { should have_many :selected_categories }
  it { should have_many(:users).through(:selected_categories) }
  it { should validate_presence_of :name }
end
