class MealplanRecipe < ApplicationRecord
  belongs_to :mealplan
  belongs_to :recipe
end
