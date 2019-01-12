class RecipeIngredientsController < ApplicationController
  def new
    @recipe_ingredient = RecipeIngredient.new(recipe_id_params)
  end

  def create
    @recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params.merge(recipe_id_params))

    if @recipe_ingredient.save
      flash[:notice] = 'Ingredient saved'
    end

    render :new
  end

  private

  def recipe_id_params
    {
      recipe_id: params[:recipe_id]
    }
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
