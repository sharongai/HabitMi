require 'rails_helper'

RSpec.describe GoalsController, sidekiq: :fake, type: :controller do
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
    before do
      3.times { FactoryGirl.create(:category) }
      2.times { FactoryGirl.create(:user) }
      get :new
    end

    it 'should respond with success' do
      expect(response).to be_success
    end

    it 'should return new goal' do
      expect(assigns(:goal)).to be_a_new Goal
    end

    it 'should return a new goal that belongs to the signed in user' do
      expect(assigns(:goal).user).to eq @user
    end

    it 'should get all categories' do
      expect(assigns(:categories).count).to eq 3
    end

    it 'should get all users without current user' do
      expect(assigns(:users).count).to eq 2
    end
  end

  describe 'POST create' do
    before do
      3.times do
        FactoryGirl.create(:category)
        FactoryGirl.create(:user)
      end
    end

    context 'with valid params' do
      before do
        @valid_create_method = -> do
          post :create,
            goal: {
              title: 'Foo',
              start_date: Date.today,
            },
            category_ids: Category.pluck(:id),
            user_ids: User.where.not(id: @user.id).pluck(:id)
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
              start_date: Date.today,
            },
            category_ids: Category.pluck(:id).to_a
        end
      end

      it 'should render new template' do
        @invalid_create_method.call
        expect(response).to render_template(:new)
      end

      it 'should not create new Goal' do
        expect { @invalid_create_method.call }.to_not change(Goal, :count)
      end

      it 'should not create any GoalCategories' do
        expect { @invalid_create_method.call }.
          to_not change(GoalCategory, :count)
      end
    end

    context 'when comments are not selected' do
      before do
        @invalid_create_method = -> do
          post :create,
            goal: {
              title: nil,
              start_date: Date.today,
            }
        end
      end

      it 'should render new template' do
        @invalid_create_method.call
        expect(response).to render_template(:new)
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

  describe 'DELETE destroy' do
    before do
      @goal = FactoryGirl.create(:goal)
      @destroy_method = -> { delete :destroy, id: @goal.id }
    end

    it 'should respond with redirect to root_path' do
      @destroy_method.call
      expect(response).to redirect_to(root_path)
    end

    it 'should destroy one goal' do
      expect { @destroy_method.call }.to change(Goal, :count).by(-1)
    end
  end

  describe 'GET show_more_strangers' do
    before do
      3.times { FactoryGirl.create(:user) }
      get :show_more_strangers, page: 0, format: :json
    end

    it 'should respond with success' do
      expect(response).to be_success
    end

    it 'should return 3 users' do
      expect(assigns(:users).count).to eq 3
    end
  end
end
