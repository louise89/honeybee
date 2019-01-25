Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :recipes do
    resources :recipe_ingredients, as: :ingredients
  end
  resources :users
end
