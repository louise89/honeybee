class Api::RecipesController < ApplicationController
   skip_before_action :verify_authenticity_token

  def add_ingredient
    if recipe.ingredients.include?(ingredient)
      render json: {error: "Ingredient already exists you fuckhead"}
    else
      recipe.ingredients << ingredient
      render json: recipe.ingredients
    end
  end

  def delete_ingredient
    if !recipe.ingredients.include?(ingredient)
      render json: {error: "Ingredient doesn't exist in this recipe you twat."}
    else
      recipe.ingredients.delete
    end
  end

  private

  def recipe
    @recipe ||= Recipe.find(recipe_id)
  end

  def ingredient
    @ingredient ||= Ingredient.find(ingredient_id)
  end

  def recipe_id
    params[:id]
  end

  def ingredient_id
    params[:ingredient_id]
  end
end
