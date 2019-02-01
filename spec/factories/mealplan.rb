FactoryBot.define do
  factory :mealplan do
    name { 'HealthyMeals' }
    # status { 'active' }
    user
  end
end
