class HomeController < ApplicationController
  def index
    # `grouped_by_day` is a method on the Recipe model that I created
    # that will select all of the Recipes and group them into days.
    #
    # This lets us display recipe's by day, like December 6, December 5, etc
    @recipes = Recipe.grouped_by_day
  end
end
