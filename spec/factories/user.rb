FactoryBot.define do
  factory :user do
    email { "#{ SecureRandom.uuid }@honeybee.com" }
    password  { 'Password123' }
    name { 'Louise' }
    admin { false }

    factory :admin do
      admin { true }
    end
  end
end
