class RecipeIngredientsController < ApplicationController
  before_action :recipe
  before_action :ensure_can_manage_recipe, only: [:create, :destroy]

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

  def destroy
    RecipeIngredient.destroy(params[:id])

    redirect_to recipe_ingredients_path
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

  def ensure_can_manage_recipe
    if !helpers.can_edit_recipe?(recipe)
      flash[:alert] = 'You cannot edit another person\'s recipe!'

      redirect_to recipe_path(recipe)
    end
  end
end
