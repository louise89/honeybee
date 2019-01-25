require 'rails_helper'

RSpec.describe RandomiserController, type: :controller do

  describe '#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    let(:create_request) do
      post :create, params: { number: number }
    end
    let(:recipes) { create_list(:recipe, 10) }
    let(:number) { 5 }

    before do
      recipes
    end

    it 'assigns @recipes to be a number of random recipes' do
      create_request
      
      expect(assigns[:recipes].length).to eql(number)
    end
  end

end
