class CreateMealplans < ActiveRecord::Migration[5.2]
  def change
    create_table :mealplans do |t|
      t.references :user
      t.column :status, :integer, default: 0
      t.string :name

      t.timestamps
    end
  end
end
