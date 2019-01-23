FactoryBot.define do
  factory :recipe_ingredient do
    quantity  { '1' }
    recipe
    ingredient
  end
end
