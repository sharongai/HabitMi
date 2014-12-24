require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  before do
    @user = FactoryGirl.create(:user)
    @goal = FactoryGirl.create(:goal)
    sign_in @user
  end

  describe 'POST create' do
    context 'with valid params' do
      before do
        @valid_create_method = -> do
          post :create, comment: {
            user: @user,
            commentable_id: @goal.id,
            body: Faker::Lorem.paragraph
          }
        end
      end

      it 'should respond with redirect' do
        @valid_create_method.call
        expect(response).to be_redirect
      end

      it 'should create a new goal' do
        expect { @valid_create_method.call }.to change(Comment, :count).by(1)
      end
    end

    context 'with invalid params' do
      before do
        @invalid_create_method = -> do
          post :create, comment: {
            user: @user,
            commentable_id: @goal.id
          }
        end
      end

      it 'should respond with render tempalte goals/show' do
        @invalid_create_method.call
        expect(response).to render_template('goals/show')
      end

      it 'should not create a new goal' do
        expect { @invalid_create_method.call }.to_not change(Goal, :count)
      end
    end
  end
end
