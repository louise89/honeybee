Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :recipes do
    member do
      post :add_ingredient
    end
  end

  resources :ingredients

  delete 'remove_recipe_ingredient/:id/:recipe_ingredient_id', to: 'recipes#remove_ingredient', as: :remove_recipe_ingredient

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
