require 'rails_helper'

RSpec.describe MealplansController, type: :controller do

  let(:mealplan) { create(:mealplan) }
  let(:current_user) { mealplan.user }

  before do
    sign_in current_user if current_user
  end

  describe '#index' do
    it 'assigns @mealplans to be all mealplans for the current user' do
      get :index

      expect(assigns[:mealplans]).to eq(current_user.mealplans)
    end
  end

  describe '#show' do
    it 'assigns a mealplan with a passed in id' do
      get :show, params: {
        id: mealplan.id
      }
      expect(assigns[:mealplan]).to eql(mealplan)
    end
  end

  describe '#new' do
    it 'assigns a new mealplan' do
      get :new
      expect(assigns[:mealplan]).to be_a_new(Mealplan)
    end

    context 'when a user is not logged in' do
      let(:current_user) { nil }

      it 'shows the flash message' do
        get :new

        expect(flash[:alert]).to eql('You need to sign in')
      end

      it 'redirects to the home page' do
        get :new

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#create' do
    let(:post_request) do
      post :create, params: {
        mealplan: {
          name: 'Healthy Plan',
          status: 'active',
          user_id: current_user.id
        }
      }
    end

    it 'creates a new mealplan' do
      expect { post_request }.to change(Mealplan, :count).by(1)
    end

    it 'shows the flash message' do
      post_request

      expect(flash[:notice]).to eql('Congratulations - recipes are saved to your mealplan')
    end

    it 'redirects to the edit page' do
      expect(post_request).to redirect_to(edit_mealplan_path(Mealplan.last))
    end

    context 'when there are invalid attributes' do
      let(:post_request) do
        post :create, params: {
          mealplan: {
            user_id: nil
          }
        }
      end

      it 'does not create a new mealplan' do
        expect {
          post_request
        }.to_not change { Mealplan.count }
      end

      it 'renders the new action' do
        post_request

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    let(:edit_request) { get :edit, params: { id: mealplan.id } }

    it 'assigns an existing mealplan' do
      edit_request

      expect(assigns[:mealplan]).to eql(mealplan)
    end

    context 'when the current user does not own the mealplan' do
      let(:current_user) { create(:user) }

      it 'redirects to the mealplan show page' do
        edit_request

        expect(response).to redirect_to(mealplan_path(mealplan))
      end

      it 'shows a flash message' do
        edit_request

        expect(flash[:alert]).to eql('You cannot edit another person\'s mealplan!')
      end
    end
  end

  describe '#update' do
    let(:new_attributes) { { name: new_name } }
    let(:new_name) { 'Unhealthy Plan' }
    let(:put_request) {
      put :update,
      params:
      {
        id: mealplan.id,
        mealplan: new_attributes
      }
    }

    it 'updates the requested mealplan' do
      put_request
      mealplan.reload
      expect(mealplan.name).to eq(new_name)
    end

    it 'shows the flash message' do
      put_request

      expect(flash[:notice]).to eql('Edit Saved')
    end

    it 'redirects to the mealplan page' do
      expect(put_request).to redirect_to(mealplan_path)
    end

    context 'when the current user does not own the mealplan' do
      let(:current_user) { User.create!(name: 'test', email: 'test2@test.com', password: 'louiseisverycool') }

      it 'redirects to the mealplan show page' do
        put_request

        expect(response).to redirect_to(mealplan_path(mealplan))
      end

      it 'shows a flash message' do
        put_request

        expect(flash[:alert]).to eql('You cannot edit another person\'s mealplan!')
      end
    end
  end

  describe '#destroy' do
    let(:delete_request) do
      delete :destroy, params: {
        id: mealplan.id
      }
    end

    before do
      mealplan
    end

    it 'deletes a mealplan' do
      expect { delete_request }.to change(Mealplan, :count).by(-1)
    end

    it 'displays a flash message' do
      delete_request

      expect(flash[:notice]).to eql('Mealplan was successfully deleted.')
    end

    it 'redirects to home page' do
      delete_request
      expect(response).to redirect_to(root_path)
    end

    context 'when the current user does not own the mealplan' do
      let(:current_user) { User.create!(name: 'test', email: 'test2@test.com', password: 'louiseisverycool') }

      it 'redirects to the mealplan show page' do
        delete_request

        expect(response).to redirect_to(mealplan_path(mealplan))
      end

      it 'shows a flash message' do
        delete_request

        expect(flash[:alert]).to eql('You cannot edit another person\'s mealplan!')
      end
    end
  end
end
