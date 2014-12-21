require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  context 'when not signed in' do
    describe 'GET index' do
      it 'should return success' do
        get :index
        expect(response).to be_success
      end
    end

    describe 'GET about_us' do
      it 'should return success' do
        get :about_us
        expect(response).to be_success
      end
    end

    describe 'GET contact_us' do
      it 'should return success' do
        get :contact_us
        expect(response).to be_success
      end
    end
  end

  context 'when signed in' do
    describe 'GET index' do
      before do
        3.times { FactoryGirl.create(:goal, created_at: Time.now + 5.days) }
        goal = FactoryGirl.create(:goal)
        @user = FactoryGirl.create(:user)
        sign_in @user
        get :index
      end

      it 'should respond with success' do
        expect(response).to be_success
      end

      it 'should only return 1 goal' do
        expect(assigns(:goals).count).to eq 1
      end
    end

    describe 'GET about_us' do
      it 'should return success' do
        get :about_us
        expect(response).to be_success
      end
    end

    describe 'GET contact_us' do
      it 'should return success' do
        get :contact_us
        expect(response).to be_success
      end
    end
  end
end
