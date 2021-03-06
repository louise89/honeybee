require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  let(:recipe) { create(:recipe) }
  let(:current_user) { recipe.user }

  before do
    sign_in current_user if current_user
  end

  describe '#show' do
    it 'assigns a recipe with a passed in id' do
      get :show, params: {
        id: recipe.id
      }
      expect(assigns[:recipe]).to eql(recipe)
    end
  end

  describe '#new' do
    it 'assigns a new recipe' do
      get :new
      expect(assigns[:recipe]).to be_a_new(Recipe)
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
        recipe: {
          name: 'Choco bits',
          description: 'Super Chocolatey',
          user_id: current_user.id
        }
      }
    end

    it 'creates a new recipe' do
      expect { post_request }.to change(Recipe, :count).by(1)
    end

    it 'shows the flash message' do
      post_request

      expect(flash[:notice]).to eql('Congratulations')
    end

    it 'redirects to the edit page' do
      expect(post_request).to redirect_to(edit_recipe_path(Recipe.last))
    end

    context 'when there are invalid attributes' do
      let(:post_request) do
        post :create, params: {
          recipe: {
            name: '',
            description: '',
            user_id: current_user.id
          }
        }
      end

      it 'does not create a new recipe' do
        expect {
          post_request
        }.to_not change { Recipe.count }
      end

      it 'renders the new action' do
        post_request

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    let(:edit_request) { get :edit, params: { id: recipe.id } }

    it 'assigns an existing recipe' do
      edit_request

      expect(assigns[:recipe]).to eql(recipe)
    end

    context 'when the current user does not own the recipe' do
      let(:current_user) { create(:user) }

      it 'redirects to the recipe show page' do
        edit_request

        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'shows a flash message' do
        edit_request

        expect(flash[:alert]).to eql('You cannot edit another person\'s recipe!')
      end
    end
  end

  describe '#update' do
    let(:new_attributes) { { name: new_name } }
    let(:new_name) { '5 guys' }
    let(:put_request) {
      put :update,
      params:
      {
        id: recipe.id,
        recipe: new_attributes
      }
    }

    it 'updates the requested recipe' do
      put_request
      recipe.reload
      expect(recipe.name).to eq(new_name)
    end

    it 'shows the flash message' do
      put_request

      expect(flash[:notice]).to eql('Edit Saved')
    end

    it 'redirects to the recipe page' do
      expect(put_request).to redirect_to(recipe_path)
    end

    context 'when the recipe doesn`t update' do
      let(:new_name) {''}

      it 'does not update the requested recipe' do
        put_request
        recipe.reload

        expect(recipe.name).to_not eq(new_name)
      end

      it 'shows the flash message' do
        put_request

        expect(flash[:alert]).to eql('Edit Not Saved')
      end

      it 'redirects to the edit page' do
        expect(put_request).to redirect_to(edit_recipe_path(recipe))
      end
    end

    context 'when the current user does not own the recipe' do
      let(:current_user) { User.create!(name: 'test', email: 'test2@test.com', password: 'louiseisverycool') }

      it 'redirects to the recipe show page' do
        put_request

        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'shows a flash message' do
        put_request

        expect(flash[:alert]).to eql('You cannot edit another person\'s recipe!')
      end
    end
  end

  describe '#destroy' do
    let(:delete_request) do
      delete :destroy, params: {
        id: recipe.id
      }
    end

    before do
      recipe
    end

    it 'deletes a recipe' do
      expect { delete_request }.to change(Recipe, :count).by(-1)
    end

    it 'displays a flash message' do
      delete_request

      expect(flash[:notice]).to eql('Recipe was successfully deleted.')
    end

    it 'redirects to home page' do
      delete_request
      expect(response).to redirect_to(root_path)
    end

    context 'when the current user does not own the recipe' do
      let(:current_user) { User.create!(name: 'test', email: 'test2@test.com', password: 'louiseisverycool') }

      it 'redirects to the recipe show page' do
        delete_request

        expect(response).to redirect_to(recipe_path(recipe))
      end

      it 'shows a flash message' do
        delete_request

        expect(flash[:alert]).to eql('You cannot edit another person\'s recipe!')
      end
    end
  end
end
