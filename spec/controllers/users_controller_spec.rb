require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create!(email: email, name: name, password: '1234567') }
  let(:email) { 'test@test.com' }
  let(:name) { 'Test test' }

  describe 'GET #show' do
    it 'should assign user to the user with the passed in ID' do
      get :show, params: user_params

      expect(assigns[:user]).to eql(user)
    end
  end
end
