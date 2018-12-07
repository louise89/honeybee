class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
  belongs_to :user

  validates_presence_of :name, :description

  def as_json(_options=nil)
    {
      id: id,
      name: name,
      description: description,
      user: user,
    }
  end
end
