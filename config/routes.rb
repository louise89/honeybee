Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :recipes do
    resources :recipe_ingredients
  end
  resources :users



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
