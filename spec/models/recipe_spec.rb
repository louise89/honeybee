require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { Recipe.new(quantity: quantity, ingredient: ingredient, recipe: recipe) }

end
