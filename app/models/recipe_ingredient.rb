class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  def name
    ingredient.name
  end

  def increase_quantity(new_quantity)
    update_attributes(quantity: quantity + new_quantity)
  end
end
