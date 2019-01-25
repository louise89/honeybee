class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates_presence_of :quantity

  accepts_nested_attributes_for :ingredient

  scope :persisted, -> { where "id IS NOT NULL" }

  def name
    ingredient.name
  end
end
