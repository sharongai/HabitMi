require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'Goal Show Page' do
  before do
    @goal = FactoryGirl.create(:goal_with_categories)
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
  end

  after { Warden.test_reset! }

  scenario 'User visits Goal Page that has not started' do
    visit goal_path(@goal)
    expect(page).to have_link 'Join Goal'
    expect(page).to_not have_link 'I did it'
  end

  scenario 'User visits goal page that has started and is participant of' do
    @goal.start_date = DateTime.now - 5.days
    @goal.participants << @user
    @goal.save
    visit goal_path(@goal)
    expect(page).to have_link 'I did it'
  end
end
