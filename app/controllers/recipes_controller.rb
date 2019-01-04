class RecipesController < ApplicationController
  before_action :require_login

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:notice] = 'Congratulations'
      redirect_to edit_recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      flash[:notice] = 'Edit Saved'
      redirect_to @recipe
    else
      flash[:alert] = 'Edit Not Saved'
      redirect_to edit_recipe_path(@recipe)
    end
  end

  private

  def require_login
    if !user_signed_in?
      flash[:alert] = 'You need to sign in'

      redirect_to root_path
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :user_id)
  end
end
