require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '#grouped_by_day' do
    let(:user) { User.create!(email: 'test@test.com', password: 'qwerty123') }

    let(:recipe_params) { { name: 'recipe', description: 'recipe', user: user } }

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
end
