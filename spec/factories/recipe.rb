FactoryBot.define do
  factory :recipe do
    name { 'Chicken Pie' }
    description  { 'Fresh parsley, Italian sausage, shallots, garlic, sun-dried tomatoes' }
    user
  end
end
