require 'rails_helper'

RSpec.describe RecipeIngredientsController, type: :controller do
  let(:recipe) { create(:recipe) }

  describe '#index' do
    let(:index_request) do
      get :index, params: {
        recipe_id: recipe.id
      }
    end

    it 'assigns recipe to be the recipe for the passed in recipe_id' do
      index_request

      expect(assigns[:recipe]).to eql(recipe)
    end

    it 'assigns a new recipe ingredient' do
      index_request

      expect(assigns[:recipe_ingredient]).to be_a_new(RecipeIngredient)
    end

    it 'contains the recipe id' do
      index_request

      expect(assigns[:recipe_ingredient].recipe_id).to eql(recipe.id)
    end
  end

  describe '#create' do
    let(:create_request) do
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

    it 'assigns recipe to be the recipe for the passed in recipe_id' do
      create_request

      expect(assigns[:recipe]).to eql(recipe)
    end

    it 'creates a new recipe ingredient' do
      expect{ create_request }.to change(RecipeIngredient, :count).by(1)
    end

    it 'shows the flash message' do
      create_request

      expect(flash[:notice]).to eql('Ingredient saved')
    end

    it 'redirect to the new recipe ingredients page' do
      create_request

      expect(response).to redirect_to(recipe_ingredients_path(recipe.id))
    end

    context 'when there are invalid attrinbutes' do
      let(:quantity) { nil }

      it 'does not create a new recipe ingredient' do
        expect{ create_request }.to_not change { RecipeIngredient.count }
      end

      it 'renders the new action' do
        create_request

        expect(response).to render_template(:index)
      end
    end
  end

  describe '#destroy' do
    subject(:destroy_request) do
      delete :destroy, params: { recipe_id: recipe.id, id: recipe_ingredient.id }
    end
    let(:recipe) { create(:recipe) }
    let(:recipe_ingredient) { create(:recipe_ingredient) }

    it 'destroys the recipe ingredient for the passed in ID' do
      recipe_ingredient

      expect{ destroy_request }.to change(RecipeIngredient, :count).by(-1)
    end

    it 'redirect to the new recipe ingredients page' do
      destroy_request

      expect(response).to redirect_to(recipe_ingredients_path(recipe.id))
    end
  end
end
