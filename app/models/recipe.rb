class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  belongs_to :user

  validates_presence_of :name, :description

  scope :grouped_by_day, -> (count: 40) do
    all.group_by { |post| post.created_at.to_date }.first(count)
  end

  def owned_by?(other_user)
    user === other_user
  end
end
