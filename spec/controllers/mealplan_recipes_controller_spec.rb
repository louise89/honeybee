require 'rails_helper'

RSpec.describe MealplanRecipesController, type: :controller do
  let(:mealplan) { create(:mealplan, user: current_user) }
  let(:recipe) { create(:recipe) }
  let(:current_user) { create(:user) }

  before do
    sign_in current_user if current_user
  end

  describe '#create' do
    let(:create_request) do
      post :create, params: {
        mealplan_id: mealplan.id,

        mealplan_recipe: {
          recipe_id: recipe.id
        }
      }
    end

    it 'creates a new mealplan recipe' do
      expect{ create_request }.to change(MealplanRecipe, :count).by(1)
    end

    it 'shows the flash message' do
      create_request

      expect(flash[:notice]).to eql('Mealplan saved')
    end

    it 'redirect to the new mealplan recipes page' do
      create_request

      expect(response).to redirect_to(mealplan_path(mealplan.id))
    end

    context 'when the current_user does not own the mealplan' do
      let(:mealplan) { create(:mealplan) }

      it 'sets a flash alert' do
        create_request

        expect(flash[:alert]).to eql('You cannot edit another person\'s mealplan!')
      end

      it 'redirects to the mealplan path' do
        create_request

        expect(response).to redirect_to(mealplan_path(mealplan.id))
      end
    end
  end

  describe '#destroy' do
    subject(:destroy_request) do
      delete :destroy, params: {
        mealplan_id: mealplan.id,
        id: mealplan_recipe.id
      }
    end
    let(:mealplan_recipe) { create(:mealplan_recipe) }

    it 'destroys the mealplan recipe for the passed in ID' do
      mealplan_recipe

      expect{ destroy_request }.to change(MealplanRecipe, :count).by(-1)
    end

    it 'redirect to the new mealplan recipes page' do
      destroy_request

      expect(response).to redirect_to(mealplan_path(mealplan.id))
    end

    context 'when the current_user does not own the mealplan' do
      let(:mealplan) { create(:mealplan) }

      it 'sets a flash alert' do
        destroy_request

        expect(flash[:alert]).to eql('You cannot edit another person\'s mealplan!')
      end

      it 'redirects to the mealplan path' do
        destroy_request

        expect(response).to redirect_to(mealplan_path(mealplan.id))
      end
    end
  end
end
