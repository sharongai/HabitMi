require 'rails_helper'

RSpec.describe GoalsController, :type => :controller do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe 'GET show' do
    before do
      @goal = FactoryGirl.create(:goal)
      get :show, id: @goal.slug
    end

    it 'should respond with success' do
      expect(response).to be_success
    end

    it 'should return @goal' do
      expect(assigns(:goal)).to eq @goal
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'should respond with success' do
      expect(response).to be_success
    end

    it 'should return new goal' do
      expect(assigns(:goal)).to be_a_new Goal
    end

    it 'should return a new goal that belongs to the signed in user' do
      expect(assigns(:goal).user).to eq @user
    end
  end

  describe 'POST create' do
    before { 3.times { FactoryGirl.create(:category) } }

    context 'with valid params' do
      before do
        @valid_create_method = -> do
          post :create,
            goal: {
              title: 'Foo',
              start_date: DateTime.now,
              category_ids: Category.pluck(:id).to_a
            }
        end
      end

      it 'should respond with success' do
        @valid_create_method.call
        expect(response).to be_redirect
      end

      it 'should create a new goal' do
        expect { @valid_create_method.call }.to change(Goal, :count).by(1)
      end

      it 'should create 3 new GoalCategories' do
        expect { @valid_create_method.call }.
          to change(GoalCategory, :count).by(3)
      end
    end

    context 'with invalid params' do
      before do
        @invalid_create_method = -> do
          post :create,
            goal: {
              title: nil,
              start_date: DateTime.now,
              category_ids: Category.pluck(:id).to_a
            }
        end
      end

      it 'should render new template' do
        @invalid_create_method.call
        expect(response).to render_template('new')
      end

      it 'should not create new Goal' do
        expect { @invalid_create_method.call }.to_not change(Goal, :count)
      end

      it 'should not create any GoalCategories' do
        expect { @invalid_create_method.call }.
          to_not change(GoalCategory, :count)
      end
    end
  end
end
