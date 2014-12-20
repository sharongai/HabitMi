require 'rails_helper'

RSpec.describe SelectedCategory, :type => :model do
  it { should belong_to :user }
  it { should belong_to :category }
  it { should validate_presence_of :user }
  it { should validate_presence_of :category }
end
