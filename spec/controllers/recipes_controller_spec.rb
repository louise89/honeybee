require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

    let(:valid_attributes) {
      {
        name: name,
        description: description,
        user_id: user.id,
      }
    }
    let(:name) { 'Chicken Pesto' }
    let(:description) { 'A recipe for food' }

    # TODO(michael): Implement factory_bot and use that instead
    let(:user) do
      User.create(
        email: "test@test.com",
        password: "qwerty123",
      )
    end

    let(:invalid_attributes) {
      {
        name: ''
      }
    }

    describe "GET #index" do
      it "assigns all recipes as @recipes" do
        recipe = Recipe.create! valid_attributes
        get :index, params: {}
        expect(assigns(:recipes)).to eq([recipe])
      end
    end

    describe "GET #show" do
      it "assigns the requested recipe as @recipe" do
        recipe = Recipe.create! valid_attributes
        get :show, params: {id: recipe.to_param}
        expect(assigns(:recipe)).to eq(recipe)
      end
    end

    describe "GET #new" do
      it "assigns a new recipe as @recipe" do
        get :new, params: {}
        expect(assigns(:recipe)).to be_a_new(Recipe)
      end
    end

    describe "GET #edit" do
      it "assigns the requested recipe as @recipe" do
        recipe = Recipe.create! valid_attributes
        get :edit, params: {id: recipe.to_param}
        expect(assigns(:recipe)).to eq(recipe)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Recipe" do
          expect {
            post :create, params: {recipe: valid_attributes}
          }.to change(Recipe, :count).by(1)
        end

        it "assigns a newly created recipe as @recipe" do
          post :create, params: {recipe: valid_attributes}
          expect(assigns(:recipe)).to be_a(Recipe)
          expect(assigns(:recipe)).to be_persisted
        end

        it "redirects to the created recipe" do
          post :create, params: {recipe: valid_attributes}
          expect(response).to redirect_to(Recipe.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved recipe as @recipe" do
          post :create, params: {recipe: invalid_attributes}
          expect(assigns(:recipe)).to be_a_new(Recipe)
        end

        it "re-renders the 'new' template" do
          post :create, params: {recipe: invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            name: new_name,
            description: description
          }
        }
        let(:new_name) { '5 guys' }
        let(:description) { 'A second recipe for food' }


        it "updates the requested recipe" do
          recipe = Recipe.create! valid_attributes
          put :update, params: {id: recipe.to_param, recipe: new_attributes}
          recipe.reload
          expect(recipe.name).to eq(new_name)
        end

        it "assigns the requested recipe as @recipe" do
          recipe = Recipe.create! valid_attributes
          put :update, params: {id: recipe.to_param, recipe: valid_attributes}
          expect(assigns(:recipe)).to eq(recipe)
        end

        it "redirects to the recipe" do
          recipe = Recipe.create! valid_attributes
          put :update, params: {id: recipe.to_param, recipe: valid_attributes}
          expect(response).to redirect_to(recipe)
        end
      end

      context "with invalid params" do
        it "assigns the recipe as @recipe" do
          recipe = Recipe.create! valid_attributes
          put :update, params: {id: recipe.to_param, recipe: invalid_attributes}
          expect(assigns(:recipe)).to eq(recipe)
        end

        it "re-renders the 'edit' template" do
          recipe = Recipe.create! valid_attributes
          put :update, params: {id: recipe.to_param, recipe: invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested recipe" do
        recipe = Recipe.create! valid_attributes
        expect {
          delete :destroy, params: {id: recipe.to_param}
        }.to change(Recipe, :count).by(-1)
      end

      it "redirects to the recipes list" do
        recipe = Recipe.create! valid_attributes
        delete :destroy, params: {id: recipe.to_param}
        expect(response).to redirect_to(recipes_url)
      end
    end


end
