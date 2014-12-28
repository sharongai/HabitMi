require 'rails_helper'

RSpec.describe ParticipationsController, :type => :controller do
  context 'When the user is not signed in' do
    before do
      @goal = FactoryGirl.create(:goal)
      @user = FactoryGirl.create(:user)
    end

    describe 'POST create' do
      before do
        @create_method = -> { post :create, goal_id: @goal.id }
      end

      it 'should redirect to new_user_session_path' do
        @create_method.call
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'should render flash' do
        @create_method.call
        expect(flash[:alert]).to be_present
      end

      it 'should not create a new participation' do
        expect { @create_method.call }.to_not change(Participation, :count)
      end
    end

    describe 'DELETE destroy' do
      before do
        @participation = FactoryGirl.create(:participation,
                                            goal: @goal, user: @user)
        @destroy_method = -> { delete :destroy, id: @participation.id }
      end

      it 'should redirect to new_user_session_path' do
        @destroy_method.call
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'should render flash' do
        @destroy_method.call
        expect(flash[:alert]).to be_present
      end

      it 'should not destroy a participation' do
        expect { @destroy_method.call }.to_not change(Participation, :count)
      end
    end

    describe 'POST score' do
      before do
        @participation = FactoryGirl.create(:participation,
                                            goal: @goal, user: @user)
        @score_method = -> { post :score, id: @participation.id }
      end

      it 'should redirect to new_user_session_path' do
        @score_method.call
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'should render flash' do
        @score_method.call
        expect(flash[:alert]).to be_present
      end

      it 'should not create a VoteLog' do
        expect { @score_method.call }.to_not change(VoteLog, :count)
      end
    end

    describe 'POST vouch' do
      before do
        @vouched_user = FactoryGirl.create(:user)
        @participation = FactoryGirl.create(:participation,
                                            goal: @goal, user: @user)
        @vouch_method = -> do
          post :vouch, id: @participation.id, participant_id: @vouched_user.id
        end
      end

      it 'should redirect to new_user_session_path' do
        @vouch_method.call
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'should render flash' do
        @vouch_method.call
        expect(flash[:alert]).to be_present
      end

      it 'should not create a VoteLog' do
        expect { @vouch_method.call }.to_not change(VoteLog, :count)
      end
    end
  end

  context 'When the user is signed in' do
    before do
      @goal = FactoryGirl.create(:goal)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    describe 'POST create' do
      before do
        @create_method = -> { post :create, goal_id: @goal.id }
      end

      it 'should redirect to goal_path' do
        @create_method.call
        expect(response).to redirect_to(goal_path(@goal))
      end

      it 'should create a new participation' do
        expect { @create_method.call }.to change(Participation, :count).by(1)
      end
    end

    describe 'DELETE destroy' do
      before do
        @participation = FactoryGirl.create(:participation,
                                            goal: @goal, user: @user)
        @destroy_method = -> { delete :destroy, id: @participation.id }
      end

      it 'should redirect to goal_path' do
        @destroy_method.call
        expect(response).to redirect_to(goal_path(@goal))
      end

      it 'should destroy a participation' do
        expect { @destroy_method.call }.to change(Participation, :count).by(-1)
      end
    end

    describe 'POST score' do
      before do
        @participation = FactoryGirl.create(:participation,
                                            goal: @goal, user: @user)
        @score_method = -> { post :score, id: @participation.id }
      end

      it 'should redirect to goal_path' do
        @score_method.call
        expect(response).to redirect_to(goal_path(@goal))
      end

      it 'should increase participation score by 100' do
        @score_method.call
        expect(Participation.find(@participation.id).score).to eq 100
      end

      it 'should create a new vote log' do
        expect { @score_method.call }.to change(VoteLog, :count).by(1)
      end
    end

    describe 'POST vouch' do
      before do
        @vouched_user = FactoryGirl.create(:user)
        @participation = FactoryGirl.create(:participation,
                                            goal: @goal, user: @user)
        @vouch_method = -> do
          post :vouch, id: @participation.id, participant_id: @vouched_user.id
        end
      end

      it 'should redirect to vouch_path' do
        @vouch_method.call
        expect(response).to redirect_to(goal_path(@goal))
      end

      it 'should increase participation score by 25' do
        @vouch_method.call
        expect(Participation.find(@participation.id).score).to eq 25
      end

      it 'should create a new vote log' do
        expect { @vouch_method.call }.to change(VoteLog, :count).by(1)
      end
    end
  end
end
