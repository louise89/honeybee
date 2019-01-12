require 'rails_helper'

RSpec.describe RecipeIngredientsController, type: :controller do
  let(:recipe) { Recipe.create!(name: name, description: description, user: user) }
  let(:name) { 'existing recipe' }
  let(:description) { 'existing desc' }

  let(:user) { User.create!(name: 'test', email: email, password: password) }
  let(:email) { 'test@test.com' }
  let(:password) { 'louiseisverycool' }

  describe '#new' do
    let(:new_request) do
      get :new, params: {
        recipe_id: recipe.id
      }
    end

    it 'assigns a new recipe ingredient' do
      new_request

      expect(assigns[:recipe_ingredient]).to be_a_new(RecipeIngredient)
    end

    it 'contains the recipe id' do
      new_request

      expect(assigns[:recipe_ingredient].recipe_id).to eql(recipe.id)
    end
  end

  describe '#create' do
    let(:post_request) do
      post :create, params: {
        recipe_id: recipe.id,

        recipe_ingredient: {
          quantity: quantity,

          ingredient_attributes: {
            name: 'anything'
          }
        }
      }
    end
    let(:quantity) { 1 }

    it 'creates a new recipe ingredient' do
      expect{ post_request }.to change(RecipeIngredient, :count).by(1)
    end

    it 'shows the flash message' do
      post_request

      expect(flash[:notice]).to eql('Ingredient saved')
    end

    it 'redirect to the new recipe ingredients page' do
      expect(post_request).to render_template(:new)
    end

    context 'when there are invalid attrinbutes' do
      let(:quantity) { nil }

      it 'does not create a new recipe ingredient' do
        expect{ post_request }.to_not change { RecipeIngredient.count }
      end

      it 'renders the new action' do
        post_request

        expect(response).to render_template(:new)
      end
    end
  end
end
