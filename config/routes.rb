# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'recipes#index', as: :recipes
  get '/recipes/:id', to: 'recipes#show', as: :recipe
  resource :recipe, only: %i[index]
end
