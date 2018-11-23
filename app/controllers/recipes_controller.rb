class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.destroy
      redirect_to recipes_path
    else
      render :edit
    end
  end

  def add_ingredient
    @recipe = Recipe.find(params[:id])

    current_ingredient = @recipe.recipe_ingredients.find_by_ingredient_id(ingredient_id)

    if current_ingredient.present?
      current_ingredient.increase_quantity(new_quantity)
    else
      @recipe.recipe_ingredients.create(recipe_ingredients_params)
    end

    render :edit
  end

  def remove_ingredient
    @recipe = Recipe.find(params[:id])
    @recipe_ingredient = RecipeIngredient.find(params[:recipe_ingredient_id])

    @recipe_ingredient.destroy
    render :edit
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :user_id)
  end

  def recipe_ingredients_params
    params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :quantity)
  end

  def ingredient_id
    recipe_ingredients_params[:ingredient_id]
  end

  def new_quantity
    recipe_ingredients_params[:quantity].to_f
  end
end
