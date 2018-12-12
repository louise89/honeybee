require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  describe '#new' do
    it 'assigns a new recipe' do
      get :new
      expect(assigns[:recipe]).to be_a_new(Recipe)
    end
  end
end
