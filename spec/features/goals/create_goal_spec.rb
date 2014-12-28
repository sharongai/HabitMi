require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'Create goal feature' do
  before do
    5.times { FactoryGirl.create(:category) }
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
    visit new_goal_path(@goal)
  end

  after { Warden.test_reset! }

  pending 'When the user has filled out the goals form correctly' do
    scenario 'When the user has filled out the goals form correctly', js: true do
      fill_in 'goal_title', with: 'Test'
    end
  end

  scenario 'When categories were not selected' do
    fill_in 'goal_title', with: 'Test'
    fill_in 'goal_start_date', with: Date.tomorrow
    click_button 'Create Goal'
    expect(page).to have_text 'You need to select Categories'
  end

  scenario '' do
  end
end
