class CreateMealplanRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :mealplan_recipes do |t|
      t.references :mealplan
      t.references :recipe

      t.timestamps
    end
  end
end
