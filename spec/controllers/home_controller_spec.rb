require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe 'GET index' do
    it 'should return success' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET about' do
    it 'should return success' do
      get :about
      expect(response).to be_success
    end
  end

  describe 'GET contact' do
    it 'should return success' do
      get :contact
      expect(response).to be_success
    end
  end
end
