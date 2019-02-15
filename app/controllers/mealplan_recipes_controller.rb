class MealplanRecipesController < ApplicationController
  before_action :mealplan
  before_action :ensure_can_manage_recipe, only: [:create, :destroy]

  def create
    @mealplan_recipe = mealplan.mealplan_recipes.build(mealplan_recipe_params)

    if @mealplan_recipe.save
      flash[:notice] = 'Mealplan saved'

      redirect_to mealplan_path(mealplan)
    else
      render :index
    end
  end

  def destroy
    MealplanRecipe.destroy(params[:id])

    redirect_to mealplan_path(mealplan)
  end

  private

  def mealplan
    @mealplan ||= Mealplan.find(params[:mealplan_id])
  end

  def mealplan_recipe_params
    params.require(:mealplan_recipe).permit(:recipe_id)
  end

  def ensure_can_manage_recipe
    if !helpers.can_edit?(mealplan)
      flash[:alert] = 'You cannot edit another person\'s mealplan!'

      redirect_to mealplan_path(mealplan)
    end
  end
end
