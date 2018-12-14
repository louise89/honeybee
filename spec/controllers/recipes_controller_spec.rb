require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  let(:user) { User.create!(name: 'test', email: email, password: password) }
  let(:email) { 'test@test.com' }
  let(:password) { 'louiseisverycool' }

  describe '#new' do
    it 'assigns a new recipe' do
      get :new
      expect(assigns[:recipe]).to be_a_new(Recipe)
    end
  end

  describe '#create' do
    let(:post_request) do
      post :create, params: {
        recipe: {
          name: 'Choco bits',
          description: 'Super Chocolatey',
          user_id: user.id
        }
      }
    end

    it 'creates a new recipe' do
      expect {
        post_request
      }.to change(Recipe, :count).by(1)
    end

    it 'shows the flash message' do
      post_request

      expect(flash[:notice]).to eql('congratulations')
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
            user_id: user.id
          }
        }
      end

      it 'does not create a new recipe' do
        expect {
          post_request
        }.to_not change { Recipe.count }
      end

      it 'shows the flash message' do
        post_request

        expect(flash[:alert]).to eql('You dun fucked up')
      end

      it 'renders the new action' do
        post_request

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    let(:recipe) { Recipe.create!(name: name, description: description, user: user) }
    let(:name) { 'existing recipe' }
    let(:description) { 'existing recipe description' }

    it 'assigns an existing recipe' do
      get :edit, params: { id: recipe.id }

      expect(assigns[:recipe]).to eql(recipe)
    end
  end

  describe '#update' do
    # let(:recipe) { Recipe.create!(name: name, description: description, user: user) }
    # let(:name) { 'existing recipe' }
    # let(:description) { 'existing recipe description' }
    #
    # let(:put_request) do
    #   put :update, params: {
    #     recipe: {
    #       name: new_name,
    #       description: new_description,
    #       user_id: user.id
    #     }
    #   }
    # end
    # let(:new_name) { 'new name' }
    # let(:new_description) { 'new desc' }

    it 'updates the requested recipe' do
      put_request
    end
  end
end
