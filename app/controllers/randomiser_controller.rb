class RandomiserController < ApplicationController

  def index
  end

  def create
    @recipes = Recipe.random(params[:number])
  end
end
