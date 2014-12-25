require 'rails_helper'

RSpec.describe SelectedCategory, :type => :model do
  it { should belong_to :user }
  it { should belong_to :category }
  it { should validate_presence_of :user }
  it { should validate_presence_of :category }
  it { should validate_uniqueness_of(:category_id).scoped_to(:user_id) }
end
