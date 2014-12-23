require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'I did it button in Goal page' do
  before do
    @user = FactoryGirl.create(:user)
    @goal = FactoryGirl.create(:goal_with_categories,
                               start_date: DateTime.now - 5.days)
    @goal.participants << @user
    @goal.save
    login_as(@user, scope: :user)
    visit goal_path(@goal)
  end

  after { Warden.test_reset! }

  scenario 'when the user has not clicked I did it!' do
    expect(page).to have_link 'I did it'
  end

  scenario 'after the user has clicked I did it!' do
    click_link 'I did it'
    expect(page).to_not have_link 'I did it'
    expect(page).to have_link 'You did it'
    expect(page).to have_text '100'
  end

  scenario 'after a day passes after the user clicked I did it' do
    click_link 'I did it'
    @user.vote_logs.last.update_attribute(:created_at, DateTime.now - 1.day)
    visit goal_path(@goal)
    expect(page).to have_link 'I did it'
  end
end
