class Mealplan < ApplicationRecord
  has_many :mealplan_recipes
  belongs_to :user

  def owned_by?(other_user)
    user === other_user
  end
end
