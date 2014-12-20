require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
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
