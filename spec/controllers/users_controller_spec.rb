require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_params) { { id: user.id } }
  let(:user) { User.create!(email: email, name: name, password: '1234567') }
  let(:user2) do
    User.create!(
      email: 'other@test.com',
      name: name,
      password: '1234567',
      admin: admin
    )
  end
  let(:admin) { false }
  let(:email) { 'test@test.com' }
  let(:name) { 'Test test' }
  let(:current_user) { user }

  before do
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe 'GET #show' do
    it 'should assign user to the user with the passed in ID' do
      get :show, params: user_params

      expect(assigns[:user]).to eql(user)
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: user_params
    end

    it 'should assign user to the user with the passed in ID' do
      expect(assigns[:user]).to eql(user)
    end

    it 'renders the edit page' do
      expect(response).to be_successful
    end

    context 'when the current user is not the user' do
      let(:current_user) { user2 }

      it 'redirects back to the user page' do
        expect(response).to redirect_to(user_path(user))
      end

      context 'when the current user is an admin' do
        let(:admin) { true }

        it 'should assign user to the user with the passed in ID' do
          expect(assigns[:user]).to eql(user)
        end

        it 'renders the edit page' do
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:update_user_params) {
      {
        id: user.id,
        user: {
          name: new_name,
          email: new_email,
        }
      }
    }
    let(:new_name) { 'new name' }
    let(:new_email) { 'new_email@test.com' }

    before do
      put :update, params: update_user_params
    end

    it 'should assign user to the user with the passed in ID' do
      expect(assigns[:user]).to eql(user)
    end

    it 'updates the user' do
      expect(user.reload.name).to eql(new_name)
      expect(user.reload.email).to eql(new_email)
    end

    it 'sets the flash message' do
      expect(flash[:notice]).to eql("User updated successfully");
    end

    it 'redirects to the user page' do
      expect(response).to redirect_to(user_path(user))
    end

    context 'when passing invalid params' do
      let(:new_name) { '' }
      let(:new_email) { '' }

      it 'renders the edit page' do
        expect(response).to render_template 'edit'
      end
    end

    context 'when the current user is not the user' do
      let(:current_user) { user2 }

      it 'does not update the user' do
        expect(user.name).to eql(name)
        expect(user.email).to eql(email)
      end

      it 'redirects back to the user page' do
        expect(response).to redirect_to(user_path(user))
      end

      context 'when the current user is an admin' do
        let(:admin) { true }

        it 'updates the user' do
          expect(user.reload.name).to eql(new_name)
          expect(user.reload.email).to eql(new_email)
        end

        it 'sets the flash message' do
          expect(flash[:notice]).to eql("User updated successfully");
        end

        it 'redirects to the user page' do
          expect(response).to redirect_to(user_path(user))
        end
      end
    end
  end
end
