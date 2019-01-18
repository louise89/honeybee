require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create!(email: 'test@test.com', password: 'qwerty123') }
  let(:recipe_params) { { name: 'recipe', description: 'recipe', user: user } }

  describe '#grouped_by_day' do

    let(:recipe1) { Recipe.create!(recipe_params.merge(created_at: date1)) }
    let(:date1) { Date.new(2018, 1, 1) }

    let(:recipe2) { Recipe.create!(recipe_params.merge(created_at: date2)) }
    let(:date2) { Date.new(2018, 2, 1) }

    before do
      recipe1
      recipe2
    end

    it 'returns an array containing the created_at and recipes' do
      expect(Recipe.grouped_by_day).to eql(
        [
          [date1, [ recipe1 ]],
          [date2, [ recipe2 ]],
        ]
      )
    end
  end

  describe 'owned_by?' do
    subject { recipe.owned_by?(other_user) }

    let(:recipe) { Recipe.create!(recipe_params) }
    let(:other_user) { user }

    it { is_expected.to be true }

    context 'when a user is not the recipe owner' do
      let(:other_user) { nil }

      it { is_expected.to be false }
    end
  end
end
