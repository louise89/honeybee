Rails.application.routes.draw do

  devise_for :users
  root 'home#index'

  resources :recipes
  resources :ingredients

  namespace :api do
    post '/recipes/:id/add_ingredient', to: 'recipes#add_ingredient', as: 'recipes'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
