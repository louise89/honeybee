# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Recipe.destroy_all
User.destroy_all

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'qwerty123',
  )
end

10.times do |n|
  rand(6 .. 13).times do
    Recipe.create!(
      name: Faker::Food.dish,
      description: Faker::Food.description,
      user: User.all.sample,
      created_at: n.days.ago,
    )
  end
end
