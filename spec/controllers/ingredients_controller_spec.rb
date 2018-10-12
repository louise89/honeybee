require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do

  let(:valid_attributes) {
    {
      name: name
    }
  }
  let(:name) { 'Food' }

  let(:invalid_attributes) {
    {
      name: ''
    }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all ingredients as @ingredients" do
      ingredient = Ingredient.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:ingredients)).to eq([ingredient])
    end
  end

  describe "GET #show" do
    it "assigns the requested ingredient as @ingredient" do
      ingredient = Ingredient.create! valid_attributes
      get :show, params: {id: ingredient.to_param}, session: valid_session
      expect(assigns(:ingredient)).to eq(ingredient)
    end
  end

  describe "GET #new" do
    it "assigns a new ingredient as @ingredient" do
      get :new, params: {}, session: valid_session
      expect(assigns(:ingredient)).to be_a_new(Ingredient)
    end
  end

  describe "GET #edit" do
    it "assigns the requested ingredient as @ingredient" do
      ingredient = Ingredient.create! valid_attributes
      get :edit, params: {id: ingredient.to_param}, session: valid_session
      expect(assigns(:ingredient)).to eq(ingredient)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Ingredient" do
        expect {
          post :create, params: {ingredient: valid_attributes}, session: valid_session
        }.to change(Ingredient, :count).by(1)
      end

      it "assigns a newly created ingredient as @ingredient" do
        post :create, params: {ingredient: valid_attributes}, session: valid_session
        expect(assigns(:ingredient)).to be_a(Ingredient)
        expect(assigns(:ingredient)).to be_persisted
      end

      it "redirects to the created ingredient" do
        post :create, params: {ingredient: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Ingredient.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved ingredient as @ingredient" do
        post :create, params: {ingredient: invalid_attributes}, session: valid_session
        expect(assigns(:ingredient)).to be_a_new(Ingredient)
      end

      it "re-renders the 'new' template" do
        post :create, params: {ingredient: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: new_name
        }
      }
      let(:new_name) { 'Chicken' }

      it "updates the requested ingredient" do
        ingredient = Ingredient.create! valid_attributes
        put :update, params: {id: ingredient.to_param, ingredient: new_attributes}, session: valid_session
        ingredient.reload
        expect(ingredient.name).to eq(new_name)
      end

      it "assigns the requested ingredient as @ingredient" do
        ingredient = Ingredient.create! valid_attributes
        put :update, params: {id: ingredient.to_param, ingredient: valid_attributes}, session: valid_session
        expect(assigns(:ingredient)).to eq(ingredient)
      end

      it "redirects to the ingredient" do
        ingredient = Ingredient.create! valid_attributes
        put :update, params: {id: ingredient.to_param, ingredient: valid_attributes}, session: valid_session
        expect(response).to redirect_to(ingredient)
      end
    end

    context "with invalid params" do
      it "assigns the ingredient as @ingredient" do
        ingredient = Ingredient.create! valid_attributes
        put :update, params: {id: ingredient.to_param, ingredient: invalid_attributes}, session: valid_session
        expect(assigns(:ingredient)).to eq(ingredient)
      end

      it "re-renders the 'edit' template" do
        ingredient = Ingredient.create! valid_attributes
        put :update, params: {id: ingredient.to_param, ingredient: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested ingredient" do
      ingredient = Ingredient.create! valid_attributes
      expect {
        delete :destroy, params: {id: ingredient.to_param}, session: valid_session
      }.to change(Ingredient, :count).by(-1)
    end

    it "redirects to the ingredients list" do
      ingredient = Ingredient.create! valid_attributes
      delete :destroy, params: {id: ingredient.to_param}, session: valid_session
      expect(response).to redirect_to(ingredients_url)
    end
  end

end
