require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  let(:recipe_ingredient) { RecipeIngredient.new(quantity: quantity, ingredient: ingredient, recipe: recipe) }
  let(:ingredient) { Ingredient.new(name: ingredient_name) }
  let(:recipe) { Recipe.new(name: recipe_name, description: description) }
  let(:ingredient_name) { 'Carrot' }
  let(:quantity) { 1 }
  let(:recipe_name) { 'Chicken Pasta' }
  let(:description) { 'recipe description' }

  describe '#name' do
    subject { recipe_ingredient.name }

    before do
      allow(recipe_ingredient).to receive(:ingredient).and_return(ingredient)
    end

    it { is_expected.to eq 'Carrot' }
  end

  describe '#quantity' do
    subject { recipe_ingredient.increase_quantity(new_quantity) }

    let(:new_quantity) { 2 }

    it { is_expected.to be true }

    it 'updates the quantity to include the new quantity' do
      subject
      expect(recipe_ingredient.quantity).to eq(3)
    end
  end
end
