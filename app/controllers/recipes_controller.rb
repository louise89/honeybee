class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:notice] = 'congratulations'
      redirect_to edit_recipe_path(@recipe)
    else
      flash[:alert] = 'You dun fucked up'
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :user_id)
  end
end
