require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  let(:recipe_ingredient) { create(:recipe_ingredient) }
  let(:ingredient) { create(:ingredient) }
  let(:recipe) { create(:recipe) }

  describe '#persisted scope' do
    let(:recipe_ingredient) { create(:recipe_ingredient) }
    let(:built_recipe_ingredient) { build(:recipe_ingredient) }

    it 'does not include recipe ingredients that have not been saved in the database' do
      expect(RecipeIngredient.persisted).not_to include(built_recipe_ingredient)
    end
  end

  describe '#name' do
    subject { recipe_ingredient.name }

    before do
      allow(recipe_ingredient).to receive(:ingredient).and_return(ingredient)
    end

    it { is_expected.to eq 'Carrot' }
  end
end
