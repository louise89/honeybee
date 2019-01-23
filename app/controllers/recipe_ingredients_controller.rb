class RecipeIngredientsController < ApplicationController
  before_action :recipe

  def index
    @recipe_ingredient = recipe.recipe_ingredients.build
  end

  def create
    @recipe_ingredient = recipe.recipe_ingredients.build(recipe_ingredient_params)

    if @recipe_ingredient.save
      flash[:notice] = 'Ingredient saved'

      redirect_to recipe_ingredients_path
    else
      render :index
    end
  end

  private

  def recipe
    @recipe ||= Recipe.find(params[:recipe_id])
  end

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(
      :quantity,
      ingredient_attributes: [
        :name
      ]
    )
  end
end
