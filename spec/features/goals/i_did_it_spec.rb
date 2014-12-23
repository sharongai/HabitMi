require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'I did it button in Goal page' do
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

  context 'User visits goal page that has started' do
    before do
      @goal.start_date = DateTime.now - 5.days
      @goal.participants << @user
      @goal.save
      visit goal_path(@goal)
    end

    scenario 'when the user has not clicked I did it!' do
      expect(page).to have_link 'I did it'
    end

    scenario 'after the user has clicked I did it!' do
      click_link 'I did it'
      expect(page).to_not have_link 'I did it'
      expect(page).to have_text '100'
    end

    scenario 'after a day passes after the user clicked I did it' do
      click_link 'I did it'
      @user.vote_logs.last.update_attribute(:created_at, DateTime.now - 1.day)
      visit goal_path(@goal)
      expect(page).to have_link 'I did it'
    end
  end
end
