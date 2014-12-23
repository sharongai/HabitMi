require 'rails_helper'

RSpec.describe Category, :type => :model do
  it { should have_attached_file :icon_image }
  it { should validate_attachment_content_type(:icon_image).
       allowing('image/png', 'image/gif', 'image/jpeg', 'image/jpg') }
  it { should validate_attachment_size(:icon_image).less_than(2.megabytes) }
  it { should have_many :goal_categories }
  it { should have_many(:goals).through(:goal_categories) }
  it { should have_many :selected_categories }
  it { should have_many(:users).through(:selected_categories) }
  it { should validate_presence_of :name }
end
