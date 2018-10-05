require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do

  describe 'GET #index' do
    it "index action should render index template" do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET#show' do
    it "show action should render show template" do
      get :show, id: Ingredient.first
      expect(response).to render_template('show')
    end
  end

  describe 'GET#new' do
    it "new action should render new template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    it "edit action should render edit template" do
      get :edit, id: Ingredient.first
      expect(response).to render_template('edit')
    end
  end

  describe "PUT update" do
    it "update action should render edit template when model is invalid" do
      Ingredient.any_instance.stubs(:valid?).returns(false)
      put :update, id: Ingredient.first
      expect(response).to render_template('edit')
    end

    it "update action should redirect when model is valid" do
      Ingredient.any_instance.stubs(:valid?).returns(true)
      put :update, id: Ingredient.first
      # response.should redirect_to(<%= item_path_for_spec('url') %>)
    end
  end

  describe 'POST #create' do
    it "create action should render new template when model is invalid" do
      Ingredient.any_instance.stubs(:valid?).returns(false)
      post :create
      response.should render_template(:new)
    end

    it "create action should redirect when model is valid" do
      Ingredient.any_instance.stubs(:valid?).returns(true)
      post :create
      # response.should redirect_to(<%= item_path_for_spec('url') %>)
    end
  end

  describe 'DELETE #destroy' do
  it "destroy action should destroy model and redirect to index action" do
      @ingredient = Ingredient.first
      delete :destroy, id: @ingredient
      # response.should redirect_to(<%= items_path('url') %>)
      Ingredient.exists?(@ingredient.id).should be_false
    end
  end
end
