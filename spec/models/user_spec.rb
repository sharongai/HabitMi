require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :selected_categories }
  it { should have_many(:categories).through(:selected_categories) }
  it { should have_many :goals }
  it { should have_many :participations }
  it { should have_many(:participating_goals).through(:participations).
       class_name('Goal') }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
end
