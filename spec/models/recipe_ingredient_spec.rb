require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  let(:recipe_ingredient) { create(:recipe_ingredient) }
  let(:ingredient) { create(:ingredient) }
  let(:recipe) { create(:recipe) }

  describe '#name' do
    subject { recipe_ingredient.name }

    before do
      allow(recipe_ingredient).to receive(:ingredient).and_return(ingredient)
    end

    it { is_expected.to eq 'Carrot' }
  end
end
