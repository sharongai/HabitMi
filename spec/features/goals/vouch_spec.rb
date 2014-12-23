require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'Vouch button in Goal page that has started' do
  before do
    @goal = FactoryGirl.create(:goal_with_categories,
                               start_date: DateTime.now - 5.days)
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
  end

  after { Warden.test_reset! }

  context 'when user is a participant' do
    before do
      @goal.participants << @user
      @goal.save
      visit goal_path(@goal)
    end

    scenario 'User visits goal page' do
      expect(page).to have_link 'Vouch'
    end

    scenario 'User clicks Vouch button' do
      click_link 'Vouch'
      expect(page).to have_text '25'
      expect(page).to have_link 'Vouched'
    end

    scenario 'after a day passes after the user vouches someone' do
      click_link 'Vouch'
      @goal.user.vote_logs.last.
        update_attribute(:created_at, DateTime.now - 1.day)
      visit goal_path(@goal)
      expect(page).to have_link 'Vouch'
    end
  end

  context 'when user is not a participant' do
    before { visit goal_path(@goal) }

    scenario 'User visits goal page' do
      expect(page).to have_link 'Vouch'
    end

    scenario 'User clicks Vouch button' do
      click_link 'Vouch'
      expect(page).to have_text '25'
      expect(page).to have_link 'Vouched'
    end

    scenario 'after a day passes after the user vouches someone' do
      click_link 'Vouch'
      @goal.user.vote_logs.last.
        update_attribute(:created_at, DateTime.now - 1.day)
      visit goal_path(@goal)
      expect(page).to have_link 'Vouch'
    end
  end
end
