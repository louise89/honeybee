class RecipesController < ApplicationController
  before_action :require_login, except: [:show]
  before_action :require_owner, only: [:edit, :update, :destroy]
  before_action :recipe, except: [:create, :new]

  def show
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
  end

  def update
    if recipe.update(recipe_params)
      flash[:notice] = 'Edit Saved'
      redirect_to recipe
    else
      flash[:alert] = 'Edit Not Saved'
      redirect_to edit_recipe_path(recipe)
    end
  end

  def destroy
    recipe.destroy

    flash[:notice] = 'Recipe was successfully deleted.'
    redirect_to root_path
  end

  private

  def require_login
    if !user_signed_in?
      flash[:alert] = 'You need to sign in'

      redirect_to root_path
    end
  end

  def require_owner
    if !helpers.can_edit_recipe?(recipe)
      flash[:alert] = 'You cannot edit another person\'s recipe!'

      redirect_to recipe_path(recipe)
    end
  end

  def recipe
    @recipe ||= Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :user_id)
  end
end
